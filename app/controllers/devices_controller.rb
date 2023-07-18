require 'httparty'

class DevicesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin, only: [:assign_device]
    
    def index
        response = HTTParty.get('https://dispenser-smart-api-fd9dea90550b.herokuapp.com/esp8266s')
        @api_data = JSON.parse(response.body)
        @users = User.all
        @devices = Device.includes(:user)
      end

    def save_data
      response = HTTParty.get('https://dispenser-smart-api-fd9dea90550b.herokuapp.com/esp8266s')
      devices = JSON.parse(response.body)
  
      devices.each do |data|
        Device.create(
          device: data['device'],
          status: data['status'],
          ipadrrs: data['ipadrrs'],
          cont: data['cont'],
          last_seen: data['last_seen']
        )
      end
  
      redirect_to devices_path, notice: 'Dados da API salvos no banco de dados.'
    end
    
    def assign_device
        @device = Device.find(params[:id])
        user = User.find(params[:user_id])
        @device.user = user
        if @device.save
            redirect_to device_path(@device), notice: 'Dispositivo atribuído com sucesso ao usuário.'
        else
            redirect_to device_path(@device), alert: 'Não foi possível atribuir o dispositivo ao usuário.'
        end
    end

    def create
      # Obtenha os parâmetros do formulário
      device_id = params[:device]
      user_id = params[:user]
  
      # Encontre o dispositivo e o usuário com base nos IDs
      device = Device.find(device_id)
      user = User.find(user_id)
  
      # Associe o dispositivo ao usuário
      device.user = user
  
      if device.save
        redirect_to device_path(device), notice: "Dispositivo associado com sucesso!"
      else
        flash[:error] = "Ocorreu um erro ao salvar as alterações do dispositivo."
        render :new
      end
    end

    def associar_dispositivo_usuario
      response = HTTParty.get('https://dispenser-smart-api-fd9dea90550b.herokuapp.com/esp8266s')
      if response.code == 200
        @devices = JSON.parse(response.body)
      else
        @devices = []
      end
  
      @users = User.all
  
      if request.post?
        # Obtenha os parâmetros do formulário
        device_id = params[:device]
        user_id = params[:user]
  
        # Encontre o dispositivo e o usuário com base nos IDs
        device = @devices.find { |d| d['id'] == device_id.to_i }
        user = User.find(user_id)
  
        # Associe o dispositivo ao usuário
        device['user_id'] = user_id
        
        # Salve as alterações no dispositivo
        # Você precisa definir a lógica para salvar as alterações no dispositivo
  
        # Redirecione ou renderize a página conforme necessário
        # Salve as alterações no dispositivo
        if device.save
          flash[:success] = "Dispositivo associado com sucesso!"
          redirect_to seu_path(device['id'])
          redirect_to device_path(device), notice: "Dispositivo associado com sucesso!"
        else
          flash[:error] = "Ocorreu um erro ao salvar as alterações do dispositivo."
          render :associar_dispositivo_usuario
        end
      end
    end


    def show
        @device = Device.find(params[:id])
        @devices = @user.devices if @user.present? && @user.devices.present?
    end

    private

    def check_admin
      redirect_to root_path, alert: 'Você não tem permissão para acessar essa página.' unless current_user.admin?
    end
end

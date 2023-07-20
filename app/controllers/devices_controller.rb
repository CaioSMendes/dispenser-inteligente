require 'httparty'

class DevicesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin, only: [:assign_device]
    
    def index
      response = HTTParty.get('https://dispenser-smart-api-fd9dea90550b.herokuapp.com/esp8266s')
        if response.code == 200
          @api_data = JSON.parse(response.body)
        else
          @api_data = []
        end
      @users = User.all
      @devices = Device.includes(:user)
    end    
   
    def associate
      selected_device = params[:device]
      user_id = params["user_device_#{selected_device}"]
      
      # Encontra o dispositivo existente ou cria um novo
      @device = Device.find_or_create_by(device: selected_device)
      
      # Define o atributo user_id para associar o dispositivo ao usuário
      @device.user_id = user_id
      
      if @device.save
        redirect_to devices_path, notice: 'Dispositivo associado com sucesso!'
      else
        redirect_to devices_path, alert: 'Erro ao associar dispositivo ao usuário.'
      end
    end
    
    
    def dissociate
      device = Device.find(params[:id])
      device.user_id = nil
      device.save
    
      redirect_to devices_path, notice: 'Associação do dispositivo removida com sucesso!'
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
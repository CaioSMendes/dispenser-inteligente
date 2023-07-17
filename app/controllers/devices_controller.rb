require 'httparty'

class DevicesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin, only: [:assign_device]
    
    def index
        response = HTTParty.get('https://dispenser-smart-api-a2db2b28d087.herokuapp.com/esp8266s')
        @api_data = JSON.parse(response.body)
    end

    def save_data
      response = HTTParty.get('https://dispenser-smart-api-a2db2b28d087.herokuapp.com/esp8266s')
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

    def show
        # Lógica para exibir um dispositivo específico
        redirect_to devices_path
        #@device = Device.find(params[:id])
        #redirect_to devices_path
    end

    private

    def check_admin
      redirect_to root_path, alert: 'Você não tem permissão para acessar essa página.' unless current_user.admin?
    end
end

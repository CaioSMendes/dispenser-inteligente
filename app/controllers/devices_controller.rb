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
    
   
    def associate
      device = params[:device]
      user_id = params["user_device_#{device}"]
    
      device_record = Device.find_or_create_by(device: device)
      device_record.user_id = user_id
      device_record.save
    
      redirect_to devices_path, notice: 'Dispositivo associado com sucesso!'
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
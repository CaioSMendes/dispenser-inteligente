class Device < ApplicationRecord
    #validates :device, uniqueness: true
    belongs_to :user, optional: true
    has_and_belongs_to_many :sellers


    #def device_name
        # Lógica para obter o nome do dispositivo
        # Por exemplo, se o nome do dispositivo estiver armazenado no campo "device" do modelo, você pode retornar assim:
        #.device
   # end

end

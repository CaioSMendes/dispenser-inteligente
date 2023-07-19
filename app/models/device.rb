class Device < ApplicationRecord
    #validates :device, uniqueness: true
    belongs_to :user, optional: true
    has_many :device_sellers
    has_many :sellers, through: :device_sellers

    #def device_name
        # Lógica para obter o nome do dispositivo
        # Por exemplo, se o nome do dispositivo estiver armazenado no campo "device" do modelo, você pode retornar assim:
        #.device
   # end

end

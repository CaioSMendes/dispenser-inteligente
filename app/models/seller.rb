class Seller < ApplicationRecord
    has_many :device_sellers
    has_many :devices, through: :device_sellers
end

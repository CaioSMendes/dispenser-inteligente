class User < ApplicationRecord
  has_many :devices
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         enum role: { admin: 'admin', user: 'user'}
end





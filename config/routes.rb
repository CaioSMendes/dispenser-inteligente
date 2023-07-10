Rails.application.routes.draw do
  get 'home/index'
  get 'esp8266/index'
  root 'home#index'

  devise_for :users
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
    end

  # Rotas para o Admin
  get 'admin/index', as: 'admin_index'

  # Rotas para o User
  get 'user/index', as: 'user_index'

  # Rotas para o Envio de SMS
  post '/send_sms', to: 'sms#send_sms'
  post '/send_sms_twilio', to: 'sms#send_sms_twilio'

  # Rotas para o Envio de Whatsapp
  post '/send_whatsapp_message', to: 'sms#send_whatsapp_message'
  post '/send_whatsapp_message_twilio', to: 'sms#send_whatsapp_message_twilio'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

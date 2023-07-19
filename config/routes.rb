Rails.application.routes.draw do
  get '/user_management', to: 'user_management#index', as: 'user_management'
  resources :sellers do
      post 'associate_device', on: :collection
  end


  get 'home/index'
  get 'esp8266/index'
  root 'home#index'
  get '/status', to: 'status#index'
  resources :devicelogs, only: [:index]
  get 'associar_dispositivo_usuario', to: 'devices#associar_dispositivo_usuario'
  delete 'devices/:id/dissociate', to: 'devices#dissociate', as: 'dissociate_device'


  resources :devices do
    post 'assign_device', on: :member
    post 'save_to_database', on: :collection
    post 'save_data', on: :collection
    post 'devices/fetch_and_save_data', to: 'devices#fetch_and_save_data', as: 'fetch_and_save_data_devices'
  end

  post 'devices/associate', to: 'devices#associate', as: 'associate_device'
  post 'devices/fetch_and_save_data', to: 'devices#fetch_and_save_data', as: 'fetch_and_save_data_devices'
  resources :devices, only: [:new, :create, :show, :destroy]
  

  devise_for :users
  resources :admin, only: [:destroy]
  resources :users, only: [:index, :show, :destroy]
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
    end

  resources :sms, only: [:index]

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

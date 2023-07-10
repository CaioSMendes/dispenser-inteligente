class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [:login, :register]

    def index
        # Adicione o código necessário para a página admin/index aqui
    end

    def after_sign_in_path_for(resource)
        if resource.admin?
          admin_index_path	
        else
          user_index_path	
        end
    end
end
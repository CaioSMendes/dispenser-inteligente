class UserController < ApplicationController
    def index
        # Adicione o código necessário para a página user/index aqui
    end
  
    def show
        @user = User.find(params[:id])
    end

end

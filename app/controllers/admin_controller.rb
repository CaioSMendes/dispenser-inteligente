class AdminController < ApplicationController
    def index
        @users = User.all
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_index_path, notice: "Usuário excluído com sucesso!"
    end
end

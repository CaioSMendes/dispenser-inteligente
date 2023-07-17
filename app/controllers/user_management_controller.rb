class UserManagementController < ApplicationController
  def index
    @users = User.all
    role = current_user.role
  end
end

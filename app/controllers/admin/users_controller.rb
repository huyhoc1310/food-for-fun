class Admin::UsersController < ApplicationController
  before_action :is_admin?
  before_action :find_user, only: %i(edit update destroy)

  def index
    @users = User.load_data.page(params[:page]).per Settings.rows
  end

  def update
    if @user.update_columns role: params[:role]
      flash[:info] = t "admin.users.update.successful"
    else
      flash[:error] = t "admin.users.update.fail"
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.users.destroy.success"
    else
      flash[:error] = t "admin.users.destroy.fail"
    end
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "admin.users.not_found"
  end

end

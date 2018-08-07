class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :load_user, except: %i(index new create)
  before_action :verify_admin!, only: :destroy
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.activated_user.load_data.page(params[:page]).per Settings.rows
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "flashs.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def user_params
    params.require(:user).permit :name, :email, :address, :phone_number, :role,
      :password, :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def verify_admin!
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flashs.not_found_user"
    redirect_to root_path
  end
end

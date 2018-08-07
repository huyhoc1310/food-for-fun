class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      if user.activated?
        log_in user
        if params[:session][:remember_me].to_i == Settings.session.remember_me
          remember user
        else
          forget user
        end
        redirect_back_or user
      else
        message = t "flashs.message"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "flashs.login_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

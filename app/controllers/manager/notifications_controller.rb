class Manager::NotificationsController < ApplicationController
  def index
    @notifications = Notification.notification.page(params[:page]).per Settings.rows
  end
end

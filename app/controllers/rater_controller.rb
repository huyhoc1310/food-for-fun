class RaterController < ApplicationController
  before_action :logged_in_user
  skip_before_action :verify_authenticity_token, only: :create

  def create
    obj = params[:klass].classify.constantize.find_by id: params[:id]
    if obj.rate params[:score].to_f, current_user, params[:dimension]
      render json: true
    else
      render json: false
    end
  end
end

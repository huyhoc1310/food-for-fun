class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create edit destroy)
  before_action :load_food, except: :new
  before_action :correct_user, only: %i(edit update destroy)

  def new
    @comment = Comment.new
    @image = @comment.images.build
  end

  def create
    @comment = @food.comments.build comment_params
    @comment.user = current_user
    if @comment.save
      flash[:success] = t "flashs.create_comment_success"
      redirect_to @food
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = t "flashs.comment_updated"
      redirect_to @food
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "flashs.comment_deleted"
    else
      flash[:danger] = t "flashs.fail_delete_comment"
    end
    redirect_to request.referrer || @food
  end

  private

  def comment_params
    params.require(:comment).permit :content,
      images_attributes: [:id, :image, :imageable_id, :imageable_type]
  end

  def load_food
    @food = Food.find_by id: params[:food_id]
    return if @food
    flash[:danger] = t "flashs.not_found_food"
    redirect_to foods_path
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end
end

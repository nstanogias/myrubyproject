class CommentsController < ApplicationController
  before_action :require_user

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      # flash[:success] = "Comment was created successfully"
      # redirect_to movie_path(@movie)
    else
      flash[:danger] = "Comment was not created"
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

end

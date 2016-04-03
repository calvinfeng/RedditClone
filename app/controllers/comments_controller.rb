class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to hub_post_url(params[:hub_id], @comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to hub_post_url(params[:hub_id],params[:id])
    end
  end

  def upvote
    Vote.create!(value: 1, votable_id: params[:id], votable_type: "Comment")
    redirect_to hub_post_url(params[:hub_id],params[:post_id])
  end

  def downvote
    Vote.create!(value: -1, votable_id: params[:id], votable_type: "Comment")
    redirect_to hub_post_url(params[:hub_id],params[:post_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end

end

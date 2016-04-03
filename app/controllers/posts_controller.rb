class PostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_post_owner, only:[:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.hub_ids = params[:post][:hub_ids]
    if @post.save
      redirect_to hub_post_url(params[:hub_id], @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    @post.hub_ids = params[:post][:hub_ids]
    if @post.update(post_params)
      redirect_to hub_post_url(params[:hub_id], params[:id])
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy if @post
    redirect_to hub_url(params[:hub_id])
  end

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find_by_id(params[:id])
    render :edit
  end

  def show
    @post = Post.find_by_id(params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end

  def upvote
    Vote.create!(value: 1, votable_id: params[:id], votable_type: "Post")
    redirect_to hub_url(params[:hub_id])
  end

  def downvote
    Vote.create!(value: -1, votable_id: params[:id], votable_type: "Post")
    redirect_to hub_url(params[:hub_id])
  end

  private
  def post_params
    params[:post].permit(:title, :url, :content)
  end

end

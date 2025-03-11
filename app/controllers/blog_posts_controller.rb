class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog_post, only: [:edit, :update, :show, :destroy]

  def index
    # Scope posts based on user_id if provided
    if params[:user_id]
      @user = User.find(params[:user_id])
      posts = @user.blog_posts.order(created_at: :desc)
    else
      posts = BlogPost.order(created_at: :desc)
    end

    # Further filter by tag if the tag parameter is present
    if params[:tag].present?
      posts = posts.tagged_with(params[:tag])
    end

    @blog_posts = posts.page(params[:page]).per(10)
  end


  def show
    @comment= Comment.new
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.author = current_user.id
    @blog_post.user = current_user
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :tag_list)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id]) 
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
  def authenticate_user! 
    redirect_to new_user_session_path, alert: "YOU MUST SIGN IN TO CONTINUE" unless user_signed_in?
  end



end

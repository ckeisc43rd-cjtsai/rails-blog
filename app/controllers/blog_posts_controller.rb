class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_blog_post, only: [:edit, :update, :show, :destroy]

    def index
        @blog_posts = if params[:user_id]
            if params[:user_id] == "44"
                User.find(params[:user_id]).blog_posts.order(created_at: :desc)
            else
                # exclude the user_id 44
                User.find(params[:user_id]).blog_posts.where.not(user_id: 44).order(created_at: :desc)
            end
          else
            #exclude the user_id 44
            BlogPost.where.not(user_id: 44).order(created_at: :desc)
          end.page(params[:page]).per(10)
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
        params.require(:blog_post).permit(:title, :body)
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
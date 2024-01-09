class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.blog_post_id=params[:blog_post_id]
        if @comment.save 
            redirect_to @comment.blog_post
        end
    end

    private
    
    def comment_params
        params.require(:comment).permit(:text)
    end
end

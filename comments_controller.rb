class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[create destroy upvote downvote]
    before_action :set_post_comment, only: %i[destroy]
    before_action :set_comment, only: %i[upvote downvote]

    

    def create
        @comment = @post.comments.create(comment_params)
        @comment.user_id = current_user.id
        
        if @comment.save
            redirect_to post_path(@post)
        else
            flash.now[:danger] = "error"
        end        
    end


    def destroy
        if @comment.destroy
            redirect_to post_path(@post)
        else
            flash.now[:danger] = "error"
        end
    end

    def upvote
        @comment.upvote_from current_user
        redirect_to @comment.post
    end

    def downvote
        @comment.downvote_from current_user
        redirect_to @comment.post
    end

    private

    def comment_params
        params.require(:comment).permit(:name, :body)
    end

    def set_post
        if @post = Post.find(params[:post_id])

        else
            flash.now[:danger] = "error"
        end
    end

    def set_post_comment
        if @comment = @post.comments.find(params[:id])

        else
            flash.now[:danger] = "error"
        end
    end

    def set_comment
        if @comment = Comment.find(params[:id])

        else
            flash.now[:danger] = "error"
        end
    end

end

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:questions, :show, :search]
  before_action :set_post, only: %i[show edit update destroy upvote downvote]
  
  def questions
    @post = Post.all.order('created_at Desc')
  end
  
  def new
    @post = current_user.posts.new 
  end

  def create

    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
    
  end

  def show
    
  end
  
  def edit
     
  end
  
  def update
     if @post.update(params[:post].permit(:title, :body))
       redirect_to @post
     else
      render 'edit'
     end
  end 

  def destroy
    if @post.destroy
      redirect_to posts_questions_url
    else
      flash.now[:danger] = "error"
    end
  end

  def search
    @post = Post.where("title LIKE ?","%" + params[:q] + "%")
  end

  def upvote
    @post.upvote_from current_user
    redirect_to @post
  end
  
  def downvote
    @post.downvote_from current_user
    redirect_to @post
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def set_post
      @post = Post.find(params[:id])

      flash.now[:danger] = "error" unless @post
    end

end

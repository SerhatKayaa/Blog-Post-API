class V1::PostsController < ApplicationController
  def index
    @posts = Post.order('created_at DESC')

    render json: @posts, status: :ok
  end

  def show
    @post = Post.where(id: params[:id])

    render json: @post, status: :ok
  end

  def create
    @post = Post.new(post_params)

   if @post.save
     render json: @post, message: "Saved Post", status: :ok
   else
     render json: @post.errors, message: "Post not saved",
            status: :unprocessable_entity
   end
  end

  def destroy
    @post = Post.where(id: params[:id]).first
    if @post.destroy
      render json: @post, status: :ok
    else
      render json: {status: 'ERROR', message:'Post not deleted', data: @post.errors },
             status: :unprocessable_entity
    end
  end

  def update
     @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render json: @post, status: :ok
    else
      render json: {status: 'ERROR', message:'Post not saved', data: @post.errors },
             status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :author)
  end
end

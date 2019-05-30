class BlogsController < ApplicationController
  before_action :move_to_index, except: :index
  def index
    @blogs = Blog.all.order('created_at DESC')
  end

  def new
    @blog = Blog.new
  end

  def destroy
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.destroy
    end
    redirect_to action: :index 
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def create
    Blog.create(create_params)
      redirect_to action: :index
  end

  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(create_params)
    end
    redirect_to action: :index
  end

  def create_params
    params.require(:blog).permit(:text).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end

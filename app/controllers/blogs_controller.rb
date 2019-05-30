class BlogsController < ApplicationController
  before_action :move_to_index, except: :index
  def index
    @blogs = Blog.all
  end

  def new
    
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
    Blog.create(text: params[:text])
  end

  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(text: params[:text])
    end
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end

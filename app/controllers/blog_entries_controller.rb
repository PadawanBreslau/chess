class BlogEntriesController < ApplicationController
  load_and_authorize_resource param_method: :blog_entry_params

  def index
    @blog_entries = BlogEntry.page(params[:page])
  end

  def new
    @blog_entry = BlogEntry.new
  end

  def create
    @blog_entry = BlogEntry.new(blog_entry_params)
    if @blog_entry.save
      redirect_to blog_entries_path(@blog_entry)
    else
      redirect_to new_blog_entry_path
    end
  end

  def show
    @blog_entry = BlogEntry.find(params[:id])
    @title = @blog_entry.title
  end

  def edit
    @blog_entry = BlogEntry.find(params[:id])
  end

  def update
    @blog_entry = BlogEntry.find(params[:id])
    @blog_entry.update_attributes(blog_entry_params)
    if @blog_entry.save
      redirect_to blog_entries_path(@blog_entry)
    else
      redirect_to :back
    end
  end

  def destroy
    BlogEntry.find(params[:id]).destroy
    redirect_to blog_entries_path
  end

  private

  def blog_entry_params
    params.require(:blog_entry).permit(:title, :content, :site_user)
  end

end

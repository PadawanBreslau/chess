class SiteCommentsController < ApplicationController

  def create
    comment = SiteComment.create(site_comment_params)
    redirect_to comment.commentable
  end

  def edit
    @site_comment = SiteComment.find(params[:id])
  end

  def update
    @site_comment = SiteComment.find(params[:id])
    @site_comment.update_attributes!(site_comment_params)
    redirect_to :root unless @site_comment.commentable
    redirect_to @site_comment.commentable
  end

  def destroy
    comment = SiteComment.find(params[:id])
    comment.destroy
    if comment.commentable.present?
      redirect_to comment.commentable
    else
      redirect_to :root
    end
  end

private

  def site_comment_params
    params.require(:site_comment).permit(:content, :site_user_id, :commentable_id, :commentable_type)
  end

end

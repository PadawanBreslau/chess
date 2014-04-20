# encoding: UTF-8
require 'spec_helper'

describe SiteCommentsController do

  context 'POST #create' do
    before do
      @blog = FactoryGirl.create(:blog_entry)
      @comment = FactoryGirl.create(
        :site_comment, commentable: @blog, site_user: @blog.site_user)
    end

    it 'creates a new site comment' do
      expect { post :create, site_comment: @comment.attributes.symbolize_keys
        }.to change(SiteComment,:count).by(1)
    end
  end

  context 'PUT #update' do
    before do
      @blog_entry = FactoryGirl.create(:blog_entry)
      @site_comment = FactoryGirl.create(:site_comment, commentable: @blog_entry, site_user: @blog_entry.site_user)
    end

    it 'should update content' do
      expect{
        put :update, id: @site_comment, site_comment: {content: 'Updated content'}
        }.not_to change(SiteComment,:count).by(1)
      assigns(:site_comment).should eql @site_comment
      @site_comment.reload
      @site_comment.content.should eql 'Updated content'
    end
  end

  context 'DELETE #delete' do
    before do
      @blog_entry = FactoryGirl.create(:blog_entry)
      @site_comment = FactoryGirl.create(:site_comment, commentable: @blog_entry, site_user: @blog_entry.site_user)
    end

    it 'should delete site_comment entry' do
       expect{
         delete :destroy, id: @site_comment
         }.to change(SiteComment,:count).by(-1)
    end

    it 'should redirect to index after destroy' do
      delete :destroy, id: @site_comment
      response.should redirect_to @blog_entry
    end
  end
end

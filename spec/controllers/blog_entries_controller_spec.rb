require 'spec_helper'

describe BlogEntriesController do

  context "GET #index" do
    it "populates an array of blog entry" do
      blog_entry = FactoryGirl.create(:blog_entry)
      get :index
      assigns(:blog_entries).to_a.should eql [blog_entry]
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  context 'GET #show' do
    it "populates an blog entry" do
      blog_entry = FactoryGirl.create(:blog_entry)
      get :show, id: blog_entry
      assigns(:blog_entry).should eql blog_entry
    end

    it "renders the :show view" do
      blog_entry = FactoryGirl.create(:blog_entry)
      get :show, id: blog_entry
      response.should render_template :show
    end
  end

  context "POST #create" do
    before do
      @blog_entry = FactoryGirl.create(:blog_entry)
    end

    it "creates a new blog entry" do
      expect{
        post :create, blog_entry: @blog_entry.attributes.symbolize_keys
        }.to change(BlogEntry,:count).by(1)
    end

    it "doesnt create a new blog entry" do
      expect{
        post :create, blog_entry: @blog_entry.attributes.symbolize_keys.merge({title: nil})
        }.not_to change(BlogEntry,:count).by(1)
    end

    it "doesnt create a new blog entry" do
      expect{
        post :create, blog_entry: @blog_entry.attributes.symbolize_keys.merge({content: nil})
        }.not_to change(BlogEntry,:count).by(1)
    end

   #it "doesnt create a new blog entry" do
   #   expect{
   #     post :create, blog_entry: {title: "AAAAAAa", content: "BBBBBBBBBBBBBBBBB"}
   #     }.not_to change(BlogEntry,:count).by(1)
   # end
  end

  context "PUT #update" do
    before do
      @blog_entry = FactoryGirl.create(:blog_entry, title: "Update test", content: "Old content for blog")
    end

    it 'should update title' do
      expect{
        put :update, id: @blog_entry, blog_entry: {title: "Updated title"}
        }.not_to change(BlogEntry,:count).by(1)
      assigns(:blog_entry).should eql @blog_entry
      @blog_entry.reload
      @blog_entry.title.should eql "Updated title"
    end

    it 'should update content' do
      expect{
        put :update, id: @blog_entry, blog_entry: {content: "New content for blog"}
        }.not_to change(BlogEntry,:count).by(1)
      assigns(:blog_entry).should eql @blog_entry
      @blog_entry.reload
      @blog_entry.content.should eql "New content for blog"
    end
  end

  context "DELETE #delete" do
    before do
      @blog_entry = FactoryGirl.create(:blog_entry, title: "Update test", content: "Old content for blog")
    end

    it 'should delete blog entry' do
       expect{
         delete :destroy, id: @blog_entry
        }.to change(BlogEntry,:count).by(-1)
    end

    it 'should redirect to index after destroy' do
      delete :destroy, id: @blog_entry
      response.should redirect_to blog_entries_url
    end
  end
end

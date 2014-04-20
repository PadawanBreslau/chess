require 'spec_helper'

describe ArticlesController do

  context "GET #index" do
    it "populates an array of article entry" do
      article = FactoryGirl.create(:article)
      get :index
      assigns(:articles).to_a.should eql [article]
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  context 'GET #show' do
    it "populates an article entry" do
      article = FactoryGirl.create(:article)
      get :show, id: article
      assigns(:article).should eql article
    end

    it "renders the :index view" do
      article = FactoryGirl.create(:article)
      get :show, id: article
      response.should render_template :show
    end
  end

  context "POST #create" do
    before do
      @article = FactoryGirl.create(:article)
    end

    it "creates a new article entry" do
      expect{
        post :create, article: @article.attributes.symbolize_keys
        }.to change(Article,:count).by(1)
    end

    it "doesnt create a new article entry" do
      expect{
        post :create, article: @article.attributes.symbolize_keys.merge({title: nil})
        }.not_to change(Article,:count).by(1)
    end

    it "doesnt create a new article entry" do
      expect{
        post :create, article: @article.attributes.symbolize_keys.merge({content: nil})
        }.not_to change(Article,:count).by(1)
    end

   #it "doesnt create a new article entry" do
   #   expect{
   #     post :create, article: {title: "AAAAAAa", content: "BBBBBBBBBBBBBBBBB"}
   #     }.not_to change(articleEntry,:count).by(1)
   # end
  end

  context "PUT #update" do
    before do
      @article = FactoryGirl.create(:article, title: "Update test", content: "Old content for article")
    end

    it 'should update title' do
      expect{
        put :update, id: @article, article: {title: "Updated title"}
        }.not_to change(Article,:count).by(1)
      assigns(:article).should eql @article
      @article.reload
      @article.title.should eql "Updated title"
    end

    it 'should update lead' do
      expect{
        put :update, id: @article, article: {lead: "New lead for article"}
        }.not_to change(Article,:count).by(1)
      assigns(:article).should eql @article
      @article.reload
      @article.lead.should eql "New lead for article"
    end

    it 'should update summary' do
      expect{
        put :update, id: @article, article: {summary: "New summary for article"}
        }.not_to change(Article,:count).by(1)
      assigns(:article).should eql @article
      @article.reload
      @article.summary.should eql "New summary for article"
    end

    it 'should update content' do
      expect{
        put :update, id: @article, article: {content: "New content for article"}
        }.not_to change(Article,:count).by(1)
      assigns(:article).should eql @article
      @article.reload
      @article.content.should eql "New content for article"
    end


  end

  context "DELETE #delete" do
    before do
      @article = FactoryGirl.create(:article, title: "Update test", content: "Old content for article")
    end

    it 'should delete article entry' do
       expect{
         delete :destroy, id: @article
         }.to change(Article,:count).by(-1)
    end

    it 'should redirect to index after destroy' do
      delete :destroy, id: @article
      response.should redirect_to articles_url
    end
  end
end

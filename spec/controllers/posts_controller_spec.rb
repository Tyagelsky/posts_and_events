require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  login_user

  before do
    @post = create(:post)
    @user = create(:user)
  end

  let(:valid_attributes) {
    { title: "Post title 2",
      description: "Post description 2",
      user_id: @user.id }
  }

  describe "GET #index" do
    it "show all posts which exist" do
      get :index
      expect(assigns(:posts)).to eq([@post])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  describe "GET #show" do
    it "show choosen post" do
      get :show , params: {id: @post.id}
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe "POST #create" do
    it "creates a new Post" do
      expect {
        post = @user.posts.create! valid_attributes
      }.to change(Post, :count).by(1)
    end

    it "assigns a newly created post" do
      post = @user.posts.create! valid_attributes
      expect(response.status).to eq(200)
      expect(post).to be_persisted
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { title: "new title" }
    }

      it "updates the requested post" do
        post = @user.posts.create! valid_attributes
        post.update new_attributes
        expect(post.title).to eq 'new title'
      end

      it "return the 200 status-code" do
        post = @user.posts.create! valid_attributes
        post.update new_attributes
        expect(response).to be_success
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post = @user.posts.create! valid_attributes
      expect {
        delete :destroy, params: {id: post.id}
      }.to change(Post, :count).by(-1)
    end
  end
end

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

      it "return the 200 status-code" do
        post = @user.posts.create! valid_attributes
        delete :destroy, params: {id: post.id}
        expect(response.status).to eq(200)
      end
    end
#
#
#   describe "GET #show" do
#     it "assigns the requested article as @article" do
#       article = Article.create! valid_attributes
#       get :show, params: {id: article.to_param}, session: valid_session
#       expect(assigns(:article)).to eq(article)
#     end
#   end
#
#   describe "POST #create" do
#     context "with valid params" do
#       it "creates a new Article" do
#         expect {
#           post :create, params: valid_attributes, session: valid_session
#         }.to change(Article, :count).by(1)
#       end
#
#       it "assigns a newly created article as @article" do
#         post :create, params: valid_attributes, session: valid_session
#         expect(assigns(:article)).to be_a(Article)
#         expect(assigns(:article)).to be_persisted
#       end
#
#       it "return the 200 status-code" do
#         post :create, params: valid_attributes, session: valid_session
#         expect(response).to be_success
#       end
#     end
#
#     context "with invalid params" do
#       it "assigns a newly created but unsaved article as @article" do
#         post :create, params: invalid_attributes, session: valid_session
#         expect(assigns(:article)).to be_a_new(Article)
#       end
#
#       it "return the 422 status-code" do
#         post :create, params: invalid_attributes, session: valid_session
#         expect(response.status).to eq(422)
#       end
#     end
#   end
#
#   describe "PUT #update" do
#     let(:new_attributes) {
#       { name: "article_new" }
#     }
#
#     let(:new_invalid_attributes) {
#       { status: nil }
#     }
#
#     context "with valid params" do
#       it "updates the requested article" do
#         article = Article.create! valid_attributes
#         new_attributes[:id] = article.to_param
#         put :update, params: new_attributes, session: valid_session
#         article.reload
#         expect(article.name).to eq 'article_new'
#       end
#
#       it "assigns the requested article as @article" do
#         article = Article.create! valid_attributes
#         new_attributes[:id] = article.to_param
#         put :update, params: new_attributes, session: valid_session
#         expect(assigns(:article)).to eq(article)
#       end
#
#       it "return the 200 status-code" do
#         article = Article.create! valid_attributes
#         new_attributes[:id] = article.to_param
#         put :update, params: new_attributes, session: valid_session
#         expect(response).to be_success
#       end
#     end
#
#     context "with invalid params" do
#       it "assigns the article as @article" do
#         article = Article.create! valid_attributes
#         new_invalid_attributes[:id] = article.to_param
#         put :update, params: new_invalid_attributes, session: valid_session
#         expect(assigns(:article)).to eq(article)
#       end
#
#       it "return the 422 status-code" do
#         article = Article.create! valid_attributes
#         new_invalid_attributes[:id] = article.to_param
#         put :update, params: new_invalid_attributes, session: valid_session
#         expect(response.status).to eq(422)
#       end
#     end
#   end
#
#   describe "DELETE #destroy" do
#     it "destroys the requested article" do
#       article = Article.create! valid_attributes
#       expect {
#         delete :destroy, params: {id: article.to_param}, session: valid_session
#       }.to change(Article, :count).by(-1)
#     end
#
#     it "return the 200 status-code" do
#       article = Article.create! valid_attributes
#       delete :destroy, params: {id: article.to_param}, session: valid_session
#       expect(response).to be_success
#     end
#   end
#
end

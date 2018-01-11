require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  login_user

  before do
    @event = create(:event)
    @post = create(:post)
    @user = create(:user)
    @comment1 = Comment.new valid_attributes
    @comment1.commentable = @post
    @comment1.save
    @comment2 = Comment.new valid_attributes
    @comment2.commentable = @comment1
    @comment2.save
    @comment3 = Comment.new valid_attributes
    @comment3.commentable = @event
    @comment3.save
  end

    let(:valid_attributes) {
      { body: "Body for comment"}
    }

  describe "POST #create" do
    it "creates a new Comment for post" do
      expect(@comment1.commentable_id). to eq(@post.id)
      expect(@comment1.commentable_type). to eq('Post')
    end

    it "creates a new Comment for event" do
      expect(@comment3.commentable_id). to eq(@event.id)
      expect(@comment3.commentable_type). to eq('Event')
    end

    it "creates a new Comment for comment" do
      expect(@comment2.commentable_id). to eq(@comment1.id)
      expect(@comment2.commentable_type). to eq('Comment')
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { body: "new body" }
    }

      it "updates the requested comment" do
        @comment1.update new_attributes
        expect(@comment1.body). to eq("new body")
      end

      it "return the 200 status-code" do
        @comment1.update new_attributes
        expect(response).to be_success
    end
  end

  describe "DELETE #destroy" do
    it "return the 200 status-code" do
      @comment2.destroy
      expect(response.status).to eq(200)
    end
  end
end

require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  login_user

  before do
    @event = create(:event)
    @user = create(:user)
  end

    let(:valid_attributes) {
      { title: "Event title 2",
        description: "Event description 2",
        start_time: DateTime.new(2018,1,10,4,5,6,'+02:00'),
        end_time: DateTime.new(2018,2,15,4,5,6,'+02:00'),
        user_id: @user.id }
    }

  describe "GET #index" do
    it "show all events which exist" do
      get :index
      expect(assigns(:events)).to eq([@event])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "show choosen event" do
      get :show , params: {id: @event.id}
      expect(assigns(:event)).to eq(@event)
    end
  end

  describe "POST #create" do
    it "creates a new Event" do
      expect {
        event = @user.events.create! valid_attributes
      }.to change(Event, :count).by(1)
    end

    it "assigns a newly created event" do
      event = @user.events.create! valid_attributes
      expect(response.status).to eq(200)
      expect(event).to be_persisted
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { title: "new title" }
    }

      it "updates the requested event" do
        event = @user.events.create! valid_attributes
        event.update new_attributes
        expect(event.title).to eq 'new title'
      end

      it "return the 200 status-code" do
        event = @user.events.create! valid_attributes
        event.update new_attributes
        expect(response).to be_success
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event" do
      event = @user.events.create! valid_attributes
      expect {
        delete :destroy, params: {id: event.id}
      }.to change(Event, :count).by(-1)
    end
  end
end

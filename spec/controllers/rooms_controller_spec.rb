require 'spec_helper'

describe RoomsController do
  def mock_room(stubs={})
    (@mock_room ||= mock_model(Room).as_null_object).tap do |room|
      room.stub(stubs) unless stubs.empty?
    end
  end

  def mock_droom(stubs={})
    (@mock_droom ||= mock_model(DetailRoom).as_null_object).tap do |room|
      detail_room.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "show index page" do
      get :index
      
    end
  end

  describe "GET show" do
    it "assigns the requested room as @room" do
      DetailRoom.stub(:find).with("1") { mock_droom }
      Room.stub(:find).with("37") { mock_room }
      get :show, {:id => "37"}
      assigns(:room).should be(mock_room)
    end
  end

  describe "GET new" do
    it "assigns a new room as @room" do
      Room.stub(:new) { mock_room }
      get :new
      assigns(:room).should be(mock_room)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created room as @room" do
        Room.stub(:new).with({'these' => 'params'}) { mock_room(:save => true) }
        post :create, :room => {'these' => 'params'}
        assigns(:room).should be(mock_room)
      end

      it "redirects to the created room" do
        Room.stub(:new) { mock_room(:save => true) }
        post :create, :room => {}
        response.should redirect_to(room_url(mock_room))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved room as @room" do
        Room.stub(:new).with({'these' => 'params'}) { mock_room(:save => false) }
        post :create, :room => {'these' => 'params'}
        assigns(:room).should be(mock_room)
      end

      it "re-renders the 'new' template" do
        Room.stub(:new) { mock_room(:save => false) }
        post :create, :room => {}
        response.should render_template("new")
      end
    end

  end
end

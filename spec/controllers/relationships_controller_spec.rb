require 'spec_helper'
describe RelationshipsController do
  describe 'GET index' do
    it 'sets @relationships to the current users following relationships' do
      kitty = Fabricate(:user)
      set_current_user(kitty)
      joan = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: kitty, leader: joan)

      get :index
      expect(assigns(:relationships)).to eq ([relationship])
    end

    it_behaves_like 'requires sign in' do
      let(:action) {get :index}
    end
  end


  describe 'DELETE destroy' do

    #we start with this sentence cuz we want to secure the delete-process
    # we dont want no current_user to delete other user from the page

    it_behaves_like 'requires sign in' do
      let(:action) {delete :destroy, id: 4}
    end

    it 'redirects to ppl-page' do
      kitty = Fabricate(:user)
      set_current_user(kitty)
      joan = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: kitty, leader: joan)

      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end
    it 'deletes the relationship if the current_user is the follower' do
      kitty = Fabricate(:user)
      set_current_user(kitty)
      joan = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: kitty, leader: joan)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end

    it 'doesnt delete the relationship if the current_user is not the follower' do
      kitty = Fabricate(:user)
      set_current_user(kitty)
      joan = Fabricate(:user)
      petra = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: petra, leader: joan)
      expect(Relationship.count).to eq(1)

    end
  end

  describe 'POST create' do
    it_behaves_like 'requires sign in' do
      let(:action) {post :create, leader_id: 4 }
    end

    it 'redirects to the people page' do
      kitty = Fabricate(:user)
      set_current_user(kitty)
      joan = Fabricate(:user)
      petra = Fabricate(:user)

      post :create, leader_id: joan.id
      expect(response).to redirect_to people_path

    end
    it 'creates a relationship that the current_user follows the leader' do

      kitty = Fabricate(:user)
      set_current_user(kitty)
      joan = Fabricate(:user)
      petra = Fabricate(:user)

      post :create, leader_id: joan.id
      expect(kitty.following_relationships.first.leader).to eq(joan)
    end

    it' does not create a relationship if the current user already follows the leader' do
      kitty = Fabricate(:user)
      set_current_user(kitty)
      joan = Fabricate(:user)
      petra = Fabricate(:user)
      Fabricate(:relationship, leader: kitty, follower: joan)
      post :create, leader_id: kitty.id
      expect(Relationship.count).to eq(1)

      #kitty = Fabricate(:user)
      #set_current_user(kitty)
      #joan = Fabricate(:user)
      #Fabricate(:relationship, leader: joan, follower: kitty)
      #post :create, leader_id: joan.id
      #expect(Relationship.count).to eq(1)
    end

    it 'does not to allow me to follow myself, add as a follower' do
      kitty = Fabricate(:user)
      set_current_user(kitty)
      post :create, leader_id: kitty.id
      expect(Relationship.count).to eq(0)
    end

  end

end
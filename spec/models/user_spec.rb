require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:full_name)}
  it {should validate_presence_of(:email)}
  it {should have_many(:queue_items).order(:position)}
  it {should have_many(:reviews).order('created_at DESC')}


  it_behaves_like 'tokenable' do
    let(:object) { Fabricate(:user) }
  end

  describe "#queue_video?" do
    it 'returns true when the user queued the video' do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      user.queue_video?(video).should be_true
    end
    it "returns false when the user hasn't queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      #Fabricate(:queue_item, user: user, video: video)
      user.queue_video?(video).should be_false
    end

  end

  describe 'follows?' do
    it 'returns true if the user has a following relationship with another user' do
      kitty = Fabricate(:user)
      joan = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: kitty, leader: joan)
      expect(kitty.follows?(joan)).to be_true
    end
    it 'returns false if the user doesnt have a follwing relationship with another user' do
      kitty = Fabricate(:user)
      joan = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: joan, leader: kitty)
      expect(kitty.follows?(joan)).to be_false
    end
  end

  describe '#followe' do
    it 'follows another user' do
      kitty = Fabricate(:user)
      tekla = Fabricate(:user)
      kitty.follow(tekla)
      expect(kitty.follows?(tekla)).to be_true
    end
    it 'doesnt follow by itself' do
      tekla = Fabricate(:user)
      #tekla.follow(tekla)
      expect(tekla.follows?(tekla)).to be_false

    end
  end
end
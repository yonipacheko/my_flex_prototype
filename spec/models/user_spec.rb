require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:full_name)}
  it {should validate_presence_of(:email)}
  it {should have_many(:queue_items).order(:position)}

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
end
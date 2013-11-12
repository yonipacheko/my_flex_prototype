require 'spec_helper'

describe QueueItem do
  it {should belong_to (:user)}
  it {should belong_to (:video)}
  describe 'video_title' do
    it ' returns the title  of the associated video ' do
      video = Fabricate(:video, title: 'futur')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('futur')
    end
  end

  describe '#rating' do
    it ' returns the rating from the review  when the review  is present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, video: video, user: user, rating: 1)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(1)

    end

    it ' return nil when review is not present' do
      video = Fabricate(:video)
      user = Fabricate(:user)

      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#category_name' do
    it " return the category's name of the video" do
      category = Fabricate(:category, name: 'terror')
      video = Fabricate(:video, categories: [category])
      queue_item = Fabricate(:queue_item,  video: video)
      expect(queue_item.category_name).to eq('terror')
    end
  end
  describe '#category' do
    it ' #category ' do
      category = Fabricate(:category, name: 'terror')
      video = Fabricate(:video, categories: [category])
      queue_item = Fabricate(:queue_item,  video: video)
      expect(queue_item.category).to eq(category)
    end
  end


end
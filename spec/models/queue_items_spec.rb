require 'spec_helper'
require 'pry'

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
     # binding.pry
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

  describe '=rating' do
    it ' change the rating of the review if the review is present' do
      #binding.pry
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, video: video, user: user, rating: 2)

      queue_item = Fabricate(:queue_item, user: user, video: video, rating: 2)
      queue_item.rating = 4

      expect(Review.first.rating).to eq(4)

    end
    it 'clears the rating of the review if the review is present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, video: video, user: user, rating: 2)

      queue_item = Fabricate(:queue_item, user: user, video: video, rating: 2)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil

    end
    it 'creates a review with rating if the review is not present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = 3
      expect(Review.first.rating).to eq(3)
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
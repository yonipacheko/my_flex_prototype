require 'spec_helper'
require 'pry'


describe Category do
  it 'saves itself' do
    category = Fabricate(:category)
    expect(assigns Category.first).to eq(category)
  end
  it { should have_many(:videos).through(:categorizations) }

  describe 'recent videos'  do
    it 'return videos in the reverse chronical order' do
      category = Fabricate(:category)
      cate = Category.create(name:'afa')
      v1 = Video.create(title: 'gog', description: 'dsf', categories: [category])
      v2 = Video.create(title: 'gog', description: 'dsf', categories: [category], created_at: 2.day.ago)
      v3 = Video.create(title: 'lalal', description: 'dsf', categories: [category], created_at: 1.day.ago)

      expect(category.recent_videos).to eq([v1,v3, v2])
    end
    it ' return all the videos if they are less than 6 videos' do
      my_category = Fabricate(:category)
      #binding.pry
      v2 = Fabricate(:video, categories: [my_category], created_at: 2.day.ago)
      #v2 = Video.create(title: 'gog', description: 'dsf', categories: [my_category], created_at: 2.day.ago)
      v3 = Video.create(title: 'lalal', description: 'dsf', categories: [my_category], created_at: 1.day.ago)

      expect(my_category.recent_videos.count).to eq(2)
    end
    it 'return 6 videos if they are more than 6'  do
      category_name = Fabricate(:category)
      7.times { Fabricate(:video, categories: [category_name])}
      expect(category_name.recent_videos.count).to eq(6)
    end
    it ' return the most recent videos' do
      category_name = Fabricate(:category)
      6.times { video = Fabricate(:video, categories: [category_name])}
      expect(category_name.recent_videos.count).to eq(6)
    end
    it 'return an empty array if the category doesnt have any videos' do
      category_name = Fabricate(:category)
      expect(category_name.recent_videos).to eq([])
    end
  end
end
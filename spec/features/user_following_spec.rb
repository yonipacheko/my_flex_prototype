require 'spec_helper'

feature 'user following' do
  scenario 'user follows and unfollows someone' do

    alice = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, categories: [category])
    Fabricate(:review, user: alice, video: video)

    sign_in
    click_video_on_home_page(video) # from Macro

    click_link alice.full_name
    click_link 'Follow'
    expect(page). to have_content(alice.full_name)

    #unfollow someone

    unfollow(alice)
    expect(page).not_to have_content(alice.full_name)


  end


  def unfollow(someone)
    find("a[data-method='delete']").click
  end
end
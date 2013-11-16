require 'spec_helper'


feature 'User interacts with the queue' do
  scenario 'user add reorders videos  in the queue' do


    comedies = Fabricate(:category)
    monk = Fabricate(:video, title: 'Monk', categories: [comedies])
    south_park = Fabricate(:video, title: 'south park', categories: [comedies])
    futurama = Fabricate(:video, title: 'futurama', categories: [comedies])


    sign_in #come that comes from Macro.rb
    #require 'pry'; binding.pry
    find("a[href='/videos/#{monk.id}']").click
    page.should have_content(monk.title)

    click_link "+ My Queue" #when the user click on this btn
    page.should have_content(monk.title)

    visit video_path(monk)
    page.should_not have_content "+ My Queue"

#************************************************************
    visit home_path
    find("a[href='/videos/#{monk.id}']").click
    click_link "+ My Queue"
    visit home_path
    find("a[href='/videos/#{south_park.id}']").click
    click_link "+ My Queue"
    visit home_path
    find("a[href='/videos/#{futurama.id}']").click
    puts page.body
    click_link "+ My Queue"

    #this searcing with ID is not an option cuz it might interfere with the F.E

    #fill_in "video_#{monk.id}", with: 3
    #fill_in "video_#{south_park.id}", with: 1
    #fill_in "video_#{futurama.id}", with: 2

    #Another better option will to use html5-data-tags

    find("input[data-video-id='#{monk.id}']").set('3')
    find("input[data-video-id='#{futurama.id}']").set('1')
    find("input[data-video-id='#{south_park.id}']").set('2')


    click_button 'Update Instant Queue'
    #using the ID-method
    #expect(find("video_#{south_park.id}").value).to eq('1')
    #expect(find("video_#{futurama.id}").value).to eq('2')
    #expect(find("video_#{monk.id}").value).to eq('3')

    #using the html5-data attr.

    expect(find("input[data-video-id='#{south_park.id}']").value).to eq('1')
    expect(find("input[data-video-id='#{futurama.id}']").value).to eq('2')
    expect(find("input[data-video-id='#{monk.id}']").value).to eq('3')


  end

end
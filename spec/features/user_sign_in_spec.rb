require 'spec_helper'

feature 'User signs in' do
  background do

  end
  scenario "with valid email an' password" do
    kitty = Fabricate(:user)
    visit sign_in_path
    fill_in 'Email address', with: kitty.email
    fill_in 'Password', with: kitty.password
    click_button 'Sign in'

    page.should have_content kitty.full_name

  end

end
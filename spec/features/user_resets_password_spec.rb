require 'spec_helper'

feature 'User resets password' do
  #We are testing here is the workflow works well and
  #and if the pages are rendering correctly
  scenario 'user succesfully reset the password' do
    kitty = Fabricate(:user, password: 'old_password')
    visit sign_in_path
    click_link 'Forgot Password?'
    fill_in 'Email address', with: kitty.email
   #require 'pry'; binding.pry
    click_button 'Send Email'
    #letter that the user gets
    open_email(kitty.email)
    current_email.click_link('Reset my password')
    #second form

    fill_in 'New Password', with: 'new_password'
    click_button 'Reset Password'

    #sign_in_page again

    fill_in 'Email address', with: kitty.email
    fill_in 'Password', with: 'new_password'
    click_button "Sign in"
    expect(page).to have_content("Welcome, #{kitty.full_name}")


  end
end
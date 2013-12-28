require 'spec_helper'

feature 'User invites Friend' do

  scenario 'User successfully invites friend and invitation is accepted', { js: true, vcr: true } do

    tekla = Fabricate(:user)
    sign_in(tekla)

    #fill up this form
    invite_a_friend

    # now we'll use Capybara-email to open the email
    #This will take to the register page with the email already in

    friend_accepts_invitation

    #Now we are at the sign_in_page
    friend_signs_in


    #We navigate to the peple-tab
    friend_should_follow(tekla)

    #we sign in again with tekla
    inviter_should_follow_friend(tekla)

    #cleaning up the emailqueue, so the email in this test doesnt lick out to other test.
    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: 'kitty'
    fill_in "Friend's Email Address", with: "k@mah.se"
    fill_in "Message", with: 'Please join this really cool site!'
    click_button  "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email "k@mah.se"
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in 'Full Name', with: 'kitty'
    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select '12 - December', from: 'date_month'
    select '2014', from: 'date_year'
    click_button "Sign Up"
  end

  def friend_signs_in
    fill_in "Email address", with: "k@mah.se"
    fill_in "Password", with: 'password'
    click_button  "Sign in"
  end

  def friend_should_follow(user)
    click_link 'People'
    expect(page).to have_content user.full_name
    sign_out
  end

  def inviter_should_follow_friend(inviter)
    sign_in(inviter)
    click_link 'People'
    expect(page).to have_content 'kitty'
  end
end
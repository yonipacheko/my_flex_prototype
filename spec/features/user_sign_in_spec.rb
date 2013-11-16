require 'spec_helper'

feature 'User signs in' do
  background do

  end
  scenario "with valid email an' password" do
    kitty = Fabricate(:user)
    sign_in(kitty) # it comes from Macro
    page.should have_content kitty.full_name

  end

end
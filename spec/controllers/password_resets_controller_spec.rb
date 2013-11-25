require 'spec_helper'

describe PasswordResetsController do
 describe 'GET show' do
   it 'renders show template if the token is valid' do
     kitty = Fabricate(:user, token: '1234')
     get :show, id: '1234'
     expect(response).to render_template :show

   end
 end

end
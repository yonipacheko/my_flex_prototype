shared_examples 'requires sign in'  do    #space and letter are case-sensitive
  it' redirects to the sign_in_page' do
    session[:user_id] = nil
    action
    expect(response).to redirect_to sign_in_path
  end

end
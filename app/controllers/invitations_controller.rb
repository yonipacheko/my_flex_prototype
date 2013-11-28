class InvitationsController < ApplicationController

  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    #we need also to merge the 'inverter-ID'
    #require 'pry'; binding.pry
    invitation = Invitation.create(user_params.merge!(inviter_id: current_user.id))

    App_Mailer.send_invitation_email(invitation).deliver
    redirect_to new_invitation_path
  end



  def user_params
    params.require(:invitation).permit!
  end

end
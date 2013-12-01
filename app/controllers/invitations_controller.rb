class InvitationsController < ApplicationController

  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    #we need also to merge the 'inverter-ID'
    #require 'pry'; binding.pry
    @invitation = Invitation.create(user_params.merge!(inviter_id: current_user.id))
    #checking if we have a value that is validated
    if @invitation.save
      App_Mailer.send_invitation_email(@invitation).deliver
      flash[:success] = "You have succesfully invited #{@invitation.recipient_name}"
      redirect_to new_invitation_path
    else
      flash[:error] = "Pls check yr inputs"

      render :new
    end
  end



  def user_params
    params.require(:invitation).permit!
  end

end
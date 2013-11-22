class RelationshipsController < ApplicationController

  before_filter :require_user

  def index
    @relationships = current_user.following_relationships
    #require 'pry'; binding.pry

  end

  def create
    other_leader = User.find(params[:leader_id])
    Relationship.create(leader_id: params[:leader_id],
    follower: current_user) unless current_user.follows?(other_leader) || current_user == other_leader
    #require 'pry'; binding.pry
    redirect_to people_path
  end

  def destroy
    #either you create a template och redirect to other temple

    relationship = Relationship.find(params[:id])   # if it was the where-method, u'll get an array right?
    relationship.destroy if relationship.follower == current_user
    #require 'pry'; binding.pry
    redirect_to people_path

  end
end



require 'pry'
module ApplicationHelper
  def options_for_video_reviews(selected = nil)
    #binding.pry
    options_for_select([5, 4, 3, 2, 1].map{ |number|
    [pluralize(number, 'Star'), number]}, selected)

  end
end


#options_for_select(container, selected = nil) A Rail method
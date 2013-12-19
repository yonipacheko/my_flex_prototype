class Video < ActiveRecord::Base
  has_many :categories, through: :categorizations
  has_many :categorizations
  has_many :queue_items
  has_many :reviews

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  validates :title,  presence: true
  validates :description, presence: true

  def self.search_by_title(searching)
   #returning
    if searching.blank?
      []
    else
      where("title LIKE ?", "%#{searching}%").order("created_at DESC")
    end
  end

end
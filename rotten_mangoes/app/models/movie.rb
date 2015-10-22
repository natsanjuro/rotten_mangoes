class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  mount_uploader :image, ImageUploader

  def review_average
    return 0 if reviews.empty? 
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  def self.search(search_text)
    where("title LIKE ? OR director LIKE ?", "%#{search_text}%", "%#{search_text}%") 
  end

  def self.run_time(minutes)
    where("runtime_in_minutes <= ?", "%#{minutes}%").to_i
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
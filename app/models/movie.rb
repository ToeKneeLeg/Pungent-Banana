class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title, :director, :description, :release_date, presence: true
  validates :runtime_in_minutes, numericality: {only_integer: true}
  validate :release_date_is_in_the_future

  scope :search_by_title, -> (string) {where("title like ?", "%#{string}%")}
  scope :search_by_director, -> (string) {where("director like ?", "%#{string}%")}
  scope :search_shorter_than_90, -> {where("runtime_in_minutes < 90")}
  scope :search_between_90_120, -> {where(runtime_in_minutes: 90..120)}
  scope :search_longer_than_120, -> {where("runtime_in_minutes > 120")}

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end

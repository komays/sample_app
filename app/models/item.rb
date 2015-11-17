class Item < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :img, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true
  validates :price, numericality: {only_float: true, greater_than: 0}
end

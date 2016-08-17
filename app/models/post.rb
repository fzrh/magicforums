class Post < ApplicationRecord
  belongs_to :topic, optional: true
  has_many :comments
  mount_uploader :image, ImageUploader
  extend FriendlyId
  friendly_id :title, use: :slugged
end

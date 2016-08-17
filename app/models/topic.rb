class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :posts
  validates :title, length: { minimum: 5 }, presence: true
end

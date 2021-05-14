class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_one_attached :post_picture

  validates :title, presence: true
end

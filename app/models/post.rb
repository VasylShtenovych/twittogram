class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_one_attached :post_picture
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  scope :ordered, ->(direction = :desc) { order(created_at: direction) }
  scope :with_authors, -> { includes(:author) }
end

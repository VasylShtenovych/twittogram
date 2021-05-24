class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_one_attached :post_picture
  has_many :comments, dependent: :destroy
  paginates_per 3
  validates :title, presence: true

  scope :ordered, ->(direction = :desc) { order(created_at: direction) }
  scope :drafts, ->(value = true) { where(draft: value) }
  scope :with_authors, -> { includes(:author) }
  scope :search, ->(query) do
    return if query.blank?

    where('title ILIKE ? OR title ILIKE ?', "#{query.squish}%", "% #{query.squish}%")
  end
end

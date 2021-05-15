class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,:rrememberable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable,  :validatable

  has_many :posts, foreign_key: :author_id, inverse_of: :author
  has_many :comments, foreign_key: :author_id, inverse_of: :author
end

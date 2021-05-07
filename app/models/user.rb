class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,:rrememberable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable,  :validatable
end

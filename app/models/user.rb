class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :recoverable, :trackable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :rememberable, :validatable

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :name, format: { with: /\A[a-zA-Z]+.+/, on: :create }

  has_many :pets
end

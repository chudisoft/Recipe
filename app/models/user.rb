class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :recipes, dependent: :destroy
  has_many :foods
  has_many :recipe_foods, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: { user: 'user', admin: 'admin' }
  validates :name, presence: true
  def is?(requested_role)
    role == requested_role.to_s
  end
end

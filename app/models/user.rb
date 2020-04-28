class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable
  has_one_attached :img
  validates :email, uniqueness: true
  has_one :spouse, class_name: 'User', foreign_key: :spouse_id
end

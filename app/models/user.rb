class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable
  has_one_attached :img
  validates :email, uniqueness: true
  belongs_to :spouse, class_name: 'User', foreign_key: :spouse_id, optional: true
  validates :email, presence: true
  validates :age, presence: true
  validates :city, presence: true
  validates :gender, presence: true
  validates :handle, presence: {
    message: -> (object, data) {
      "nick name must be present"
    }
  }

  def set_tags
    update tags: "#{email} #{age} #{question_1} #{question_2} #{question_3} #{city} #{gender} #{handle}".gsub(/[\.-_]/, ' ')
  end
end

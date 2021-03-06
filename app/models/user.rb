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


  validates_format_of :email,:with => Devise::email_regexp
  
  after_create :set_tags
  def set_tags
    update tags: "#{email} #{age} #{question_1} #{question_2} #{question_3} #{city} #{gender} #{handle}"
  end

  def new_password
    new_p = "abcdefghijklmnopqrstuvwxyz1234567890".split('').sample(6).join
    self.password = new_p
    self.password_confirmation = new_p
    self.save
    new_p
  end
end

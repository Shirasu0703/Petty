class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  has_one_attached :image

  def get_profile_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

  def self.look_for(word, method)
    if method == "perfect"
      @user = User.where("name LIKE ?", "#{word}")
    elsif method == "forward"
      @user = User.where("name LIKE ?", "#{word}%")
    elsif method == "backward"
      @user = User.where("name LIKE ?", "%#{word}")
    elsif method == "partial"
      @user = User.where("name LIKE ?", "%#{word}%")
    end
  end

  def active_for_authentication?
    super && is_active
  end

  def inactive_message
    "このアカウントは退会済みです。"
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end

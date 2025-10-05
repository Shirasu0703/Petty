class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true

  def active_for_authentication?
    super && is_active
  end

  def inactive_message
    "このアカウントは退会済みです。"
  end
end

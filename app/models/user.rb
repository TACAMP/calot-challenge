class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_image

  has_many :posts , dependent: :destroy
  has_many :favorites , dependent: :destroy
  has_many :comments , dependent: :destroy
  has_many :relationships , class_name: "Relationship" , foreign_key: "follower_id" , dependent: :destroy
  has_many :reserve_of_relationships , class_name: "Relationship" , foreign_key: "followed_id" , dependent: :destroy
  has_many :followings , through: :relationships , source: :followed
  has_many :followers , through: :reserve_of_relationships , source: :follower

  validates :name , length: {minimum: 2,maximum: 30} ,uniqueness: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  #検索分岐
  def self.looks(searches, words)
    if searches == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end

end

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
  has_many :active_notifications , class_name: 'Notification' , foreign_key: 'visitor_id' , dependent: :destroy
  has_many :passive_notifications , class_name: 'Notification' , foreign_key: 'visited_id' , dependent: :destroy

  validates :name , presence: true , length: {maximum: 30}

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
  def self.looks(words)
    @user = User.where("name LIKE ?", "%#{words}%")
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?",current_user.id ,id , 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end

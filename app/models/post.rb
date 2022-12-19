class Post < ApplicationRecord

  has_one_attached :post_image

  belongs_to:user
  has_many:favorites , dependent: :destroy
  has_many:comments , dependent: :destroy
  has_many:post_tags , dependent: :destroy
  has_many:tags , through: :post_tags
  has_many:camp_tools ,dependent: :destroy
  has_many:notifications , dependent: :destroy
  accepts_nested_attributes_for :camp_tools , allow_destroy: true

  validates :title , presence: true
  validates :description , length: {maximum: 500}

  #Favoriteモデルにuserが存在するか確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    #古いタグを削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    #新しいタグを作成
    new_tags.each do |new|
      new_post_tags = Tag.find_or_create_by(name: new)
      self.tags << new_post_tags
    end
  end

  #検索分岐
  def self.looks(words)
    @post = Post.where("title LIKE ?", "%#{words}%")
  end

  def create_notification_favorites!(current_user)
    #すでにいいねされているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = '?' ", current_user.id , user_id , id , 'Favorite'])
    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id ,
        visited_id: user_id ,
        action: 'Favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end

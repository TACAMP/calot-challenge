class Post < ApplicationRecord

  has_one_attached :post_image

  belongs_to:user
  has_many:favorites , dependent: :destroy
  has_many:comments , dependent: :destroy
  has_many:post_tags , dependent: :destroy
  has_many:tags , through: :post_tags

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
  def self.looks(searches, words)
    if searches == "perfect_match"
      @post = Post.where("title LIKE ?", "#{words}")
    else
      @post = Post.where("title LIKE ?", "%#{words}%")
    end
  end
end

class Tag < ApplicationRecord

  has_many:post_tags , dependent: :destroy , foreign_key: 'tag_id'
  has_many:posts , through: :post_tags
  validates :name , uniqueness: true , presence: true

  #検索分岐
  def self.looks(words)
    @tag = Tag.where("name LIKE ?", "%#{words}%")
  end

end

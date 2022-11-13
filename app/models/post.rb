class Post < ApplicationRecord

  has_one_attached :post_image

  belongs_to:user
  has_many:favorites , dependent: :destroy

  #Favoriteモデルにuserが存在するか確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end

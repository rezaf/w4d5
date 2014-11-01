class Sub < ActiveRecord::Base
  validates :title, :moderator_id, presence: true
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :sub_id,
    primary_key: :id
  )
  
  def sub_posts
    Post.all.where("sub_id = ?", self.id)
  end
  
end

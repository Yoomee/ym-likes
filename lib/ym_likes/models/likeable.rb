module YmLikes::Likeable

  def self.included(base)
    base.has_many :likings, :as => :resource, :class_name => 'Like', :dependent => :destroy
    base.has_many :likers, :through => :likings, :source => :user
    base.scope :most_likes, -> { base.joins("LEFT OUTER JOIN likes ON (likes.resource_id = #{base.table_name}.id AND likes.resource_type = '#{base.to_s}')").select("#{base.table_name}.*, COUNT(likes.id) AS like_count").order('like_count DESC').group("#{base.table_name}.id") }
    base.scope :liked_by, -> (user) { base.joins(:likings).where(likes: {user_id: user.id}) }
  end

end

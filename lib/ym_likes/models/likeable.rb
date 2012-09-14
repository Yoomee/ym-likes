module YmLikes::Likeable
  
  def self.included(base)
    base.has_many :likes, :as => :resource, :class_name => 'YmLikes::Like', :dependent => :destroy
    base.scope :most_likes, base.joins("LEFT OUTER JOIN likes ON (likes.resource_id = #{base.table_name}.id AND likes.resource_type = '#{base.to_s}')").select("#{base.table_name}.*, COUNT(likes.id) AS like_count").order('like_count DESC').group("#{base.table_name}.id")
  end
  
end
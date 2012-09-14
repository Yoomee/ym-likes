module YmLikes::UserExt
  
  def self.included(base)
    base.has_many(:likes, :class_name => "YmLikes::Like", :dependent => :destroy)
  end

end
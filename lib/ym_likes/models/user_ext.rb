module YmLikes::UserExt
  
  def self.included(base)
    base.has_many(:likes, :dependent => :destroy)
  end

end
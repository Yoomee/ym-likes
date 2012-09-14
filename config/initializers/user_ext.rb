YmUsers::User.class_eval do

  class << self
    
    def included_with_ym_likes(base)
      included_without_ym_likes(base)
      base.send(:include, YmLikes::UserExt)
    end
    alias_method_chain :included, :ym_likes
    
  end
  
end

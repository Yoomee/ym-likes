module YmLikes::Like
  
  def self.included(base)
    base.send(:include, YmCore::Model)
    base.belongs_to :user
    base.belongs_to :resource, :polymorphic => true
    base.validates_presence_of :user, :resource
  end
  
end
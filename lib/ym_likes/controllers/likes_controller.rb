module YmLikes::LikesController

  def self.included(base)
    base.load_and_authorize_resource :except => :relike
  end

  def create
    @like = current_user.likes.find_or_create_by_resource_type_and_resource_id(params[:resource_type], params[:resource_id])
    if request.xhr?
      render :json => @like.as_json(:only => [:id, :removed_at])
    else
      redirect_to @like.resource
    end
  end

  def unlike
    @like.update_attribute(:removed_at, Time.now)
    render :json => @like.as_json(:only => [:id, :removed_at])
  end
  
  def relike
    @like = Like.unscoped.where(:id => params[:id]).first
    authorize! :relike, @like
    @like.update_attribute(:removed_at, nil)
    render :json => @like.as_json(:only => [:id, :removed_at])
  end

end

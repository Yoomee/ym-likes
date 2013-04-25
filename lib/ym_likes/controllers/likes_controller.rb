module YmLikes::LikesController

  def self.included(base)
    base.load_and_authorize_resource
  end

  def create
    @like = current_user.likes.find_or_create_by_resource_type_and_resource_id(params[:resource_type], params[:resource_id])
    if request.xhr?
      render :json => @like.as_json(:only => [:id, :resource_id, :resource_type])
    else
      redirect_to @like.resource
    end
  end

  def destroy
    @like.destroy
    render :json => @like.as_json(:only => [:resource_id, :resource_type])
  end

end

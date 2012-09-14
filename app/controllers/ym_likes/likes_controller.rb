class YmLikes::LikesController < ApplicationController

  load_and_authorize_resource :class => 'YmLikes::Like'

  def create
    @like = current_user.likes.find_or_create_by_resource_type_and_resource_id(params[:resource_type], params[:resource_id])
    render :json => @like.as_json(:only => [:id, :resource_id, :resource_type])
  end

  def destroy
    @like.destroy
    render :json => @like.as_json(:only => [:resource_id, :resource_type])
  end

end
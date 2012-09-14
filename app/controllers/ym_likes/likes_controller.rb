class YmLikes::LikesController < ApplicationController

  load_and_authorize_resource :class => 'YmLikes::Like'

  def create
    @like = current_user.likes.find_or_create_by_resource_type_and_resource_id(params[:resource_type], params[:resource_id])
    render :action => "add_remove"
  end

  def destroy
    @like.destroy
    render :action => "add_remove"
  end

end
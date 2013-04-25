module YmLikes::LikesHelper

  def like_link(resource, options = {})
    options.reverse_merge!(:like_text => "Like", :unlike_text => "Unlike", :like_title => "Like", :unlike_title => "Unlike", :remote => true)
    options[:class] = "#{options[:class]} like-link".strip
    resource_hash = {:resource_type => resource.class.to_s, :resource_id => resource.id}
    options[:data] = options.slice(:like_text, :unlike_text)
    existing_like = ::Like.unscoped.where(resource_hash.merge(:user_id => current_user.id)).first
    if existing_like.nil? || existing_like.removed_at.present?
      url = existing_like ? relike_like_path(existing_like) : create_like_path(resource_hash)
      options[:method] = existing_like ? :put : :post
      options.delete(:unlike_text)
      link_text = options.delete(:like_text)
      options[:title] = options.delete(:like_title)
    else
      url = unlike_like_path(existing_like)
      options[:method] = :put      
      options.delete(:like_text)
      link_text = options.delete(:unlike_text)
      options[:title] = options.delete(:unlike_title)
      options[:class] += " active"
    end
    link_to(url, options) do
      content_tag(:i, "", :class => "icon-heart") + " #{link_text}"
    end

  end

end
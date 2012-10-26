module YmLikes::LikesHelper

  def like_link(resource, options = {})
    options.reverse_merge!(:like_text => "Like", :unlike_text => "Unlike", :like_title => "Like", :unlike_title => "Unlike")
    options.reverse_merge!(:remote => true) if current_user
    options[:class] = "#{options[:class]} like-link".strip
    resource_hash = {:resource_type => resource.class.to_s, :resource_id => resource.id}
    options[:data] = options.slice(:like_text, :unlike_text)
    if current_user && like = current_user.likes.where(resource_hash).first
      url = like_path(like)
      options.delete(:like_text)
      link_text = options.delete(:unlike_text)
      options[:title] = options.delete(:unlike_title)
      options[:method] = :delete
      options[:class] += " active"
    else
      url = current_user ? create_like_path(resource_hash) : create_like_logged_out_path(resource_hash)
      options.delete(:unlike_text)
      link_text = options.delete(:like_text)
      options[:title] = options.delete(:like_title)
      options[:method] = :post
    end
    link_to(url, options) do
      content_tag(:i, "", :class => "icon-heart") + " #{link_text}"
    end

  end

end
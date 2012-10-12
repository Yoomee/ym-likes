module YmLikes::LikesHelper

  def like_link(resource, options = {})
    return "" if current_user.nil?
    options.reverse_merge!(:remote => true, :like_text => "Like", :unlike_text => "Unlike")
    options[:class] = "#{options[:class]} like-link".strip
    resource_hash = {:resource_type => resource.class.to_s, :resource_id => resource.id}
    options[:data] = options.slice(:like_text, :unlike_text)
    if like = current_user.likes.where(resource_hash).first
      url = like_path(like)
      options.delete(:like_text)
      options[:title] = options.delete(:unlike_text)
      options[:method] = :delete
      options[:class] += " active"
    else
      url = create_like_path(resource_hash)
      options.delete(:unlike_text)
      options[:title] = options.delete(:like_text)
      options[:method] = :post
    end
    link_to(url, options) do
      content_tag(:i, "", :class => "icon-heart") + " #{options[:title]}"
    end

  end

end
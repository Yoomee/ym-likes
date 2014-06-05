module YmLikes::LikesHelper

  def like_link(resource, options = {})
    link_text, url, options = generate_like_options(resource, options)
    link_to(link_text, url, options)
  end

  def like_link_with_count(resource, options = {})
    link_text, url, options = generate_like_options(resource, options)
    link_to(url, options) do
      content_tag(:span, "#{link_text} like us", class: "pull-left") + content_tag(:i, "", class: "fa fa-heart pull-right")
    end
  end

  private

  def generate_like_options(resource, options)
    options.reverse_merge!(:like_text => "Like", :unlike_text => "Unlike", :like_title => "Like", :unlike_title => "Unlike", :remote => true, :icon => 'heart')
    options[:class] = "#{options[:class]} like-link".strip
    resource_hash = {:resource_type => resource.class.to_s, :resource_id => resource.id}
    options[:data] = options.slice(:like_text, :unlike_text)
    if current_user
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
    else
      options[disabled: true]
      link_text = options.delete(:like_text)
      url = '#'
    end
    return link_text, url, options
  end

end

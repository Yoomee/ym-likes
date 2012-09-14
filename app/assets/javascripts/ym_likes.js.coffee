window.YmLikes =
  init: () ->
    $('a.like-link').live 'ajax:beforeSend', (event) =>
      $(event.target).addClass('loading')
    $('a.like-link').live 'ajax:success', (event, data) =>
      YmLikes.refreshLink($(event.target), data)
  refreshLink: (likeLink, data) ->
    if likeLink.hasClass('active')
      params = "resource_type=#{data.resource_type}&resource_id=#{data.resource_id}"       
      likeLink.removeClass('active').data('method', 'post').attr('href', "/likes/?#{params}")
      likeLink.html(likeLink.html().replace(likeLink.data('unlike-text'), likeLink.data('like-text')))      
    else
      likeLink.addClass('active').data('method', 'delete').attr('href', "/likes/#{data.id}")
      likeLink.html(likeLink.html().replace(likeLink.data('like-text'), likeLink.data('unlike-text')))    
    likeLink.removeClass('loading')
    
$ ->
  YmLikes.init()
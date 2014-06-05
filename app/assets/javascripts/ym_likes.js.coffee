window.YmLikes =
  init: () ->
    $('a.like-link').live 'ajax:beforeSend', (event) =>
      $(event.target).addClass('loading')
    $('a.like-link').live 'ajax:success', (event, data) =>
      YmLikes.refreshLink($(event.target), data)
  refreshLink: (likeLink, data) ->
    if data.removed_at
      likeLink.html(likeLink.html().replace(likeLink.data('unlike-text'), likeLink.data('like-text')))
      url = "/likes/#{data.id}/relike/"
    else
      likeLink.html(likeLink.html().replace(likeLink.data('like-text'), likeLink.data('unlike-text')))
      url = "/likes/#{data.id}/unlike"
    likeLink.removeClass('active').data('method', 'put').attr('href', url)
    likeLink.removeClass('loading')

$ ->
  YmLikes.init()

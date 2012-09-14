window.YmLikes =
  init: () ->
    $('a.like-link').live 'ajax:beforeSend', (event) =>
      console.log('hello')
      $(event.target).tooltip('hide').addClass('loading')

$ ->
  YmLikes.init()
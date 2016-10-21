$(document).on 'turbolinks:load', ->
  $('.ui.dropdown').dropdown()

$(document).on 'turbolinks:load', ->
  if $('#sidebar-trigger').length
    $('.ui.sidebar').sidebar 'attach events', '#sidebar-trigger'



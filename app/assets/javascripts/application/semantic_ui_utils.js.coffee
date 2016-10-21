$(document).on 'turbolinks:load', ->
  $('.ui.dropdown').dropdown()

$(document).on 'ready turbolinks:load', ->
  # $('.ui.sidebar').sidebar 'attach events', '.menu .item'
  $('.ui.sidebar').sidebar(context: $('.bottom.segment')).sidebar 'attach events', '.menu .item'


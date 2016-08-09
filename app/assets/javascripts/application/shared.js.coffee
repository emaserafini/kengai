$(document).on 'click', '[data-behaviour~=submit-on-check]', ->
  $(@).closest('form').submit()

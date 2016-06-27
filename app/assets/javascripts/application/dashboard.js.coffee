$(document).on 'click', '[data-behavior~=submit_on_check]', ->
  $(@).closest('form').submit()
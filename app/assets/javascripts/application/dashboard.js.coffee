# $(document).on 'click', '[data-behavior~=submit_on_check]', ->
#   form = $(@).closest('form')
#   # console.log form.attr('action')
#   # console.log form.serialize()
#   request = $.ajax(
#     type: 'POST'
#     url: form.attr('action')
#     data: form.serialize())

#   request.done (msg) ->
#     console.log msg
#     return
#   request.fail (jqXHR, textStatus) ->
#     alert 'Request failed: ' + textStatus
#     return

  # $.ajax(
  #   method: 'POST'
  #   url: 'some.php'
  #   data:
  #     name: 'John'
  #     location: 'Boston').done (msg) ->
  #   alert 'Data Saved: ' + msg
  #   return


# $('form').submit ->
#   valuesToSubmit = $(this).serialize()
#   $.ajax(
#     type: 'POST'
#     url: $(this).attr('action')
#     data: valuesToSubmit
#     dataType: 'JSON').success (json) ->
#     console.log 'success', json
#     return
#   false
$(document).on 'ready page:load', ->

  # eventHandler = () ->
  #   form = $(@).closest('form')
  #   console.log form.serialize()
  #   # $.ajax(
  #   #   type     : 'POST'
  #   #   url      : form.attr('action')
  #   #   data     : form.serialize()
  #   #   dataType : 'JSON'
  #   # ).success (json) ->
  #   #   console.log 'success', json
  #   #   return
  #   false

  $('.ui.checkbox[data-behaviour~=submit-on-check]').checkbox
    onChecked: ->
      $(@).closest('div').checkbox 'set disabled'
    onUnchecked: ->
      $(@).closest('div').checkbox 'set disabled'
    onChange: ->
      form = $(@).closest('form')
      request = $.ajax(
        type     : 'POST'
        url      : form.attr 'action'
        data     : form.serialize()
        dataType : 'JSON')
      request.success (msg) =>
        $(@).closest('div').checkbox 'set enabled'
        return
      request.fail (jqXHR, textStatus) =>
        if $(@).is ':checked'
          $(@).closest('div').checkbox 'set unchecked'
        else
          $(@).closest('div').checkbox 'set checked'
        $(@).closest('div').checkbox 'set enabled'


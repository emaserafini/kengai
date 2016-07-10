$(document).on 'turbolinks:load', ->
  $('.ui.checkbox[data-behaviour~=submit-on-check]').checkbox
    beforeChecked: ->
      if $(@).attr('wait') == 'true'
        return false
      else
        $(@).attr('wait', true)
    beforeUnchecked: ->
      if $(@).attr('wait') == 'true'
        return false
      else
        $(@).attr('wait', true)
    onChange: ->
      form = $(@).closest('form')
      request = $.ajax(
        type     : 'POST'
        url      : form.attr 'action'
        data     : form.serialize()
        dataType : 'JSON')
      request.success =>
        $(@).attr('wait', false)
      request.fail =>
        if $(@).is ':checked'
          $(@).closest('div').checkbox 'set unchecked'
        else
          $(@).closest('div').checkbox 'set checked'
        $(@).attr('wait', false)

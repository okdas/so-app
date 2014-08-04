# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('ul.chat .vote').click ->
    answerId = $(this).parents().get(2).id
    $('#' + answerId + ' .vote').bind 'ajax:success', (e, data, status, xhr) ->
      votecount = $.parseJSON(xhr.responseText)
      $('#' + answerId + ' .votecount').html(votecount.vote_size)
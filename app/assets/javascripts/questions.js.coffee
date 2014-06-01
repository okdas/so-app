# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$(".tagsinput").tagsInput();

#$('.question > .vote').bind 'ajax:success', (e, data, status, xhr) ->
#  console.log(xhr)
#  votecount = $.parseJSON(xhr)
#  $('.question .votecount').html(votecount.vote_size)

questionId = $('.question').data('questionId')
PrivatePub.subscribe '/questions/' + questionId + '/votes', (data, channel) ->
  console.log(data)
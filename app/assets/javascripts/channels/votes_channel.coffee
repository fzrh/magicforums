votesChannelFunctions = () ->

  if $('.container.comments').length > 0
    App.votes_channel = App.cable.subscriptions.create {
      channel: 'VotesChannel'
    },
    connected: () ->
      console.log('Cast your vote!')
    disconnected: () ->
    received: (data) ->
      $(".comment[data-id=#{data.comment_id}] .voting-score").html(data.value)

$(document).on 'turbolinks:load', votesChannelFunctions

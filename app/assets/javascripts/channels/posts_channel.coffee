postsChannelFunctions = () ->
  checkMe = (comment_id) ->
    if $('meta[name=admin]').length < 1
      $(".comment[data-id=#{comment_id}] .control-panel").remove()
    $(".comment[data-id=#{comment_id}]").removeClass('hidden')

  if $('.container.comments').length > 0
    App.posts_channel = App.cable.subscriptions.create {
      channel: 'PostsChannel'
    },
    connected: () ->
      console.log("I'm loaded")

    disconnected: () ->

    received: (data) ->
      console.log(data)
      if $('.container.comments').data().id == data.post.id && $(".comment[data-id=#{data.comment.id}]").length < 1
        $('#comments').append(data.partial)
        checkMe(data.comment.id)

$(document).on 'turbolinks:load', postsChannelFunctions

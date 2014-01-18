window.Thumbnailer =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Thumbnailer.Routers.Entries()
    Backbone.history.start()

$(document).ready ->
  Thumbnailer.initialize()

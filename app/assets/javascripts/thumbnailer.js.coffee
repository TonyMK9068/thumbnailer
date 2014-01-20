window.Thumbnailer =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Thumbnailer.Routers.Products()
    Backbone.history.start(pushState: true)
    

$(document).ready ->
  Thumbnailer.initialize()

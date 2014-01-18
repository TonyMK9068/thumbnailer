class Thumbnailer.Routers.Entries extends Backbone.Router
# takes a url path and maps it to a js function
  routes:
    '': 'index'
    'entries/:id': 'show'
    
  initialize: ->
    @collection = new Thumbnailer.Collections.Entries()
    @collection.fetch()

  index: ->
    view = new Thumbnailer.Views.EntriesIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Entry #{id}"
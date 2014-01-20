class Thumbnailer.Routers.Products extends Backbone.Router
  routes:
    '': 'index'
    'products/:id': 'show'

  initialize: ->
    @collection = new Thumbnailer.Collections.Products()
    @collection.fetch()

  index: ->
    view = new Thumbnailer.Views.ProductsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show:(id) ->
    product = @collection.get(id)
    view = new Thumbnailer.Views.ProductsShow(model: product)
    $('#product-container').append(view.render().el)
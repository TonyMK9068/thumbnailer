class Thumbnailer.Views.ProductsIndex extends Backbone.View
  template: JST['products/index']
    
  initialize: ->
    @collection.on('sync', @render, this)
  
  render: ->
    $(@el).html(@template())
    @collection.each(@appendProduct)
    this
    
  appendProduct: (product) ->
    view = new Thumbnailer.Views.Product(model: product)
    $('#product-container').append(view.render().el)

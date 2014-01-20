class Thumbnailer.Views.ProductsShow extends Backbone.View
  template: JST['products/show']

  initialize: ->
    @model.on('sync', @render, this)
  
  render: ->
    $(@el).html(@template(item: @model))
    $('#js-show-product').modal('show')
    this


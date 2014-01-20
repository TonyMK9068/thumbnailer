class Thumbnailer.Views.Product extends Backbone.View
  template: JST['products/product']
  
  events: ->
    'click button#show-product': 'showProduct'
  
  render: ->
    $(@el).html(@template(product: @model))
    this
  
  showProduct: ->
    Backbone.history.navigate("products/#{@model.get('id')}", true)
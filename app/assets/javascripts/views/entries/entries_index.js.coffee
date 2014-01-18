class Thumbnailer.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']
  
  initialize: ->
    @collection.on('sync', @render, this)
  
  render: ->
    $(@el).html(@template(entries: @collection))
    this

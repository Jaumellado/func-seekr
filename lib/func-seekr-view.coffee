{SelectListView} = require 'atom-space-pen-views'
module.exports =
class FuncSeekrView extends SelectListView
  initialize: (self)->
    @self = self
    super

  setPanel: (@panel) ->
    console.log("Setting panel")

  viewForItem: (item) ->
    "<li>#{item.replace(/\/\/(.*?)\//, "// <big>$1</big> /")}</li>"

  confirmed: (item) ->
    console.log("#{item} was selected")

  cancelled: ->
    @panel.hide()

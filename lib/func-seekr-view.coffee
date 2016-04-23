{SelectListView} = require 'atom-space-pen-views'
module.exports =
class FuncSeekrView extends SelectListView
  initialize: (self)->
    @self = self
    super

  viewForItem: (item) ->
    "<li>#{item.replace(/\/\/(.*?)\//, "// <big>$1</big> /")}</li>"

  confirmed: (item) ->
    console.log("#{item} was selected")

  cancelled: ->
    @self.panelHide()

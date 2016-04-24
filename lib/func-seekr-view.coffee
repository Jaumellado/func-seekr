WebBrowserView = require './func-browser-view'
{SelectListView} = require 'atom-space-pen-views'
module.exports =
class FuncSeekrView extends SelectListView
  initialize: (self)->
    @self = self
    super

  setFilterKey: (@filterKey) ->
    console.log("setting filterKey")
    console.log "#{@filterKey}"

  getFilterKey: ->
    return @filterKey

  setPanel: (@panel) ->
    console.log("Setting panel")

  viewForItem: (item) ->
    "<li>#{item.filename.replace(/\/\/(.*?)\//, "// <big>$1</big> /")}</li>"

  confirmed: (item) ->
    @panel.hide()
    params = {
      url: item.url,
      size:
        type: "integer"
        default: 450,
      position:
        default: "right"
        type: "string"
        enum: ["top", "right", "bottom", "left"]
    }
    @webBrowserView = new WebBrowserView(params, this)
    atom.workspace.addRightPanel(item: @webBrowserView)
    #console.log("#{item} was selected")

  cancelled: ->
    @panel.hide()

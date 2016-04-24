WebBrowserView = require './func-browser-view'
{SelectListView} = require 'atom-space-pen-views'
module.exports =
class FuncSeekrView extends SelectListView
  initialize: (self)->
    @self = self
    super

  setPanel: (@panel) ->
    console.log("Setting panel")

  viewForItem: (item) ->
    #"<li>#{item.replace(/\/\/(.*?)\//, "// <big>$1</big> /")}</li>"
    "<li class='two-lines'>
      <div class='primary-line'>#{item.filename}</div>
      <div class='secondary-line'>#{item.url}</div>
    </li>"

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

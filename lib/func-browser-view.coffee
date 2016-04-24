{View, $} = require "atom-space-pen-views"
module.exports =
class WebSearchBrowserView extends View
  @content: (params, self) ->
    p = params.position
    s = params.size
    style = if ["top", "bottom"].indexOf(p) > -1 then "height:#{s}px" else "width:#{s}px"
    @div id:"webSearch", style:style, =>
      @div id:"webSearchBar", class:"web-search inline-block",  =>
        @button "close", outlet:"close", style:"float:right", class:"btn"
      @div =>
        @tag "webview", class:"inline-block native-key-bindings", src:"#{params.url}", outlet:"webview"

  attached: (onDom) ->
    @webview
      .height($("#webSearch").height() - $("#webSearchBar").height())
      .width($("#webSearch").width())

  initialize: (params, self) ->
    @self = self
    @close.on "click", =>
      panels = atom.workspace.getRightPanels()
      panels[0].hide()

  setURL: (url) ->
    @webview.attr("src", url)

FuncSeekrView = require './func-seekr-view'
request = require 'request'
{CompositeDisposable} = require 'atom'

module.exports = FuncSeekr =
  FuncSeekrView: null
  modalPanel: null
  subscriptions: null
  thisExtension: null
  allGists: null
  wantedGists: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'func-seekr:openSeekr': => @openSeekr()

    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer?.file
    filename = file?.getBaseName()
    filename = filename.split('.')
    @thisExtension = filename[filename.length-1]

  openSeekr: ->
    e = atom.workspace.getActiveTextEditor()
    return unless e?
    if @FuncSeekrView is null
      @FuncSeekrView = new FuncSeekrView(this)
    @modalPanel ?= atom.workspace.addModalPanel(item: @FuncSeekrView)
    @modalPanel.show()
    @FuncSeekrView.focusFilterEditor()
    @FuncSeekrView.setItems []

  search: (text)->
    @getAllGists()
    for key, value of @allGists
      files = value['files']
      #console.log "#{key} and #{value['url']}"
      for key of files
        fileName = key.split('.')
        if fileName.length > 1
          extension = fileName[fileName.length-1]
          #console.log "#{extension}"
          if extension = thisExtension
            @wantedGists.add(key)
    @showResults()

  showResults: ->
    if @FuncSeekrView is null
      @FuncSeekrView = new FuncSeekrView(this)
    @modalPanel ?= atom.workspace.addModalPanel(item: @FuncSeekrView)
    @modalPanel.show()
    @FuncSeekrView.focusFilterEditor()
    @FuncSeekrView.setItems @wantedGists

  getAllGists: ->
    resp = ""
    request.get {
      uri:'https://api.github.com/gists/public?client_id=79cbac24f101f20ebe89&client_secret=bf5e196e52ce682e0e6b66371911941c00ba15dc',
      headers: 'User-Agent': 'request'
      }, (err, r, body) ->
      resp = body
      @allGists = JSON.parse(resp)


  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @FuncSeekrView.destroy()
    @ResultsView.destroy()

  panelHide: ->
    @modalPanel?.hide()

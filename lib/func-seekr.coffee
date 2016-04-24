FuncSeekrView = require './func-seekr-view'
request = require 'request'
{CompositeDisposable} = require 'atom'

module.exports = FuncSeekr =
  FuncSeekrView: null
  WebBrowserView: null
  modalPanel: null
  subscriptions: null
  thisExtension: null
  newPage: "chrome://newtab"

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'func-seekr:search': => @search()

    #editor = atom.workspace.getActivePaneItem()
    #file = editor?.buffer?.file
    #filename = file?.getBaseName()
    #filename = filename.split('.')
    #@thisExtension = filename[filename.length-1]

  search: ->
    gists = []
    resp = ""
    request.get {
      uri:'https://api.github.com/gists/public?client_id=79cbac24f101f20ebe89&client_secret=bf5e196e52ce682e0e6b66371911941c00ba15dc',
      headers: 'User-Agent': 'request'
      }, (err, r, body) ->
      resp = body
      data = JSON.parse(resp)
      for key, value of data
        files = value['files']
        #console.log "#{key} and #{value['url']}"
        for key, value of files
          item = {
            filename: value['filename'],
            url: value['raw_url']
          }
          gists.push(item)
          #fileName = key.split('.')
          #if fileName.length > 1
            #extension = fileName[fileName.length-1]
            #console.log "#{extension}"
            #if extension = thisExtension
              #@wantedGists.add(key)
      @FuncSeekrView = new FuncSeekrView(this)
      @modalPanel ?= atom.workspace.addModalPanel(item: @FuncSeekrView)
      @modalPanel.show()
      @FuncSeekrView.setPanel(@modalPanel)
      @FuncSeekrView.setFilterKey('filename')
      @FuncSeekrView.focusFilterEditor()
      @FuncSeekrView.setItems gists

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @FuncSeekrView.destroy()
    @ResultsView.destroy()

  panelHide: ->
    @modalPanel.hide()

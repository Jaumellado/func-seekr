FuncSeekrView = require './func-seekr-view'
{CompositeDisposable} = require 'atom'

module.exports = FuncSeekr =
  funcSeekrView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @funcSeekrView = new FuncSeekrView(state.funcSeekrViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @funcSeekrView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'func-seekr:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @funcSeekrView.destroy()

  serialize: ->
    funcSeekrViewState: @funcSeekrView.serialize()

  toggle: ->
    console.log 'FuncSeekr was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

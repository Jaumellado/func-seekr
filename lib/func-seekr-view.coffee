request = require 'request'
module.exports =
class FuncSeekrView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('func-seekr')

    # Create message element
    message = document.createElement('div')
    message.textContent = "Type your search:"
    message.classList.add('message')
    @element.appendChild(message)

    searchBar = document.createElement('form')
    inputText = document.createElement('input')
    searchBar.appendChild(inputText)
    @element.appendChild(searchBar)

    searchButton = document.createElement('button')
    searchButton.textContent = "Search"
    textValue = inputText.value

    searchButton.onclick = search(textValue)
    @element.appendChild(searchButton)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  search = (textValue)->
    resp = ""
    request.get {
      uri:'https://api.github.com/gists/public?access_token=4c67ecb52700d9fd3d702e971bb3be7b3ccf45c7',
      headers: 'User-Agent': 'request'
      }, (err, r, body) ->
      resp = body
      editor = atom.workspace.getActivePaneItem()
      file = editor?.buffer?.file
      filename = file?.getBaseName()
      filename = filename.split('.')
      fileExtension = filename[filename.length-1])
      for gist in resp

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

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

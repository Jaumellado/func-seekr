request = require 'request'
json = require 'JSON'

resp = ""
request.get {
  uri:'https://api.github.com/gists/public?client_id=79cbac24f101f20ebe89&client_secret=bf5e196e52ce682e0e6b66371911941c00ba15dc',
  headers: 'User-Agent': 'request'
  }, (err, r, body) ->

  resp = body

  #console.log "BODY: "+ resp + "\n" + err + "\nR: " + r
  data = json.parse(resp)

  for key, value of data
    files = value['files']
    #console.log "#{key} and #{value['url']}"
    for key of files
      fileName = key.split('.')
      if fileName.length > 1
        extension = fileName[fileName.length-1]
        console.log "#{extension}"

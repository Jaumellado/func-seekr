request = require 'request'

resp = ""
request.get {
  uri:'https://api.github.com/gists/public?access_token=4c67ecb52700d9fd3d702e971bb3be7b3ccf45c7',
  headers: 'User-Agent': 'request'
  }, (err, r, body) ->

  resp = body

  console.log "BODY: "+ resp + "\n" + err + "\nR: " + r

// includes the http node library and makes an object using it:
var http = require('http'); 

// this creates the server - when stuff comes in call dothestuff()
// listen on port 1337 on the localhost
http.createServer(dothestuff).listen(1337, '127.0.0.1');

// this runs when you do the stuff
function dothestuff(req, res)
{
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('<html><body><b>Hello</b> <i>World</i></body></html>');

}

// print out that we're up and running:
console.log('Server running at http://127.0.0.1:1337/ !!!!!');
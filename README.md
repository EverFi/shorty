# URL shortener

Write a url shortener service as a Rack app (inspired by https://bitly.com).

This REST/HTTP based service should do 2 things:

1. with a POST, shorten a url and return the shortened url
2. with a GET, retrieve a previously shortened url

There's no UI. Assume a single-threaded/single-instance server for now. No need to use an external database service. If you stop the rack service, it's ok if any previously shortened urls are lost.

# Your task

Look at `lib/shorty.rb`, which has a stubbed out version of the server.

Run the specs in spec/shorty_spec.rb and complete the Shorty class so that the specs pass.

    bundle install
    bundle exec rake

## Rack basics

Rack apps are very simple: you provide a class with a method named `call(env)`.

All incoming requests are handled in the same `call` method.
There's no built-in url routing or http method matching.
You have to write this yourself.

A rack app must return an array with 3 items:
* http response code
* hash of headers (Content-types etc)
* a response body (must also be enumerable, an array of strings work)

## Command line test

Start the rack server in one tab

    bundle exec ruby rackup.ru

In another tab, store a URL like

    $ curl -X POST localhost:8080/ --data "url=http://test.com"
    http://localhost:8080/2a8an9g

Retrieve this shortened url

    $ curl -I -X GET http://localhost:8080/2a8an9g
    HTTP/1.1 302 Found
    Location: http://test.com

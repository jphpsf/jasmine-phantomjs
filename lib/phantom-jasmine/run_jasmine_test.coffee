#!/usr/local/bin/phantomjs

# Runs a Jasmine Suite from an html page
# @page is a PhantomJs page object
# @exit_func is the function to call in order to exit the script

class PhantomJasmineRunner
  constructor: (@page, @exit_func = phantom.exit) ->
    @tries = 0
    @max_tries = 10

  get_status: -> @page.evaluate(-> consoleReporter.status)

  terminate: ->
    switch @get_status()
      when "success" then @exit_func 0
      when "fail"    then @exit_func 1
      else                @exit_func 2

# Script Begin
if phantom.args.length == 0
  console.log "Need a url as the argument"
  phantom.exit 1

page = new WebPage()

runner = new PhantomJasmineRunner(page)

# Don't supress console output
page.onConsoleMessage = (msg) ->
  console.log msg

address = phantom.args[0]

page.open address, (status) ->
  runner.terminate()
{spawn, exec} = require 'child_process'

task 'spec', 'Spec for Suger Pod', (options) ->
  ls = spawn 'ls', ['./node_modules/jasmine-node']
  ls.stderr.on 'data', (data) ->
    if data.toString().match /No such file or directory/
      console.log "You should install 'jasmine-node'"
      console.log '  $ npm install jasmine-node'
  jasmine = spawn './node_modules/jasmine-node/bin/jasmine-node', ['--color', '--coffee', 'spec/lib']
  dataHandler = (data) -> console.log data.toString().trim()
  jasmine.stdout.on 'data', dataHandler
  jasmine.stderr.on 'data', dataHandler

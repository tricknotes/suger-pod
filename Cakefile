{spawn, exec} = require 'child_process'

task 'spec', 'Spec for Suger Pod', (options) ->
  jasmine = spawn './node_modules/jasmine-node/bin/jasmine-node', ['--color', '--coffee', 'spec/lib']
  dataHandler = (data) -> console.log data.toString().trim()
  jasmine.stdout.on 'data', dataHandler
  jasmine.stderr.on 'data', dataHandler

coffee = require 'coffee-script'

exports.compile = (source, options) ->
  str = exports.preCompile(source, options)
  (locals) ->
      coffee.compile(str)

exports.preCompile = (source, options) ->
  source.replace /@@([a-zA-Z]+)/, (_, name) ->
    switch typeof value = options[name]
      when 'string'
        "'#{value.replace(/\n/g, '\\n').replace("'", "\\'")}'"
      when 'function'
        "`#{value.toString()}`"
      when 'object'
        "`#{JSON.stringify(value)}`"
      else
        value

exports.render = (source, options) ->
  exports.compile(source, options)()

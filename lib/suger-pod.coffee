coffee = require 'coffee-script'

exports.compile = (source, _) ->
  (locals) ->
    str = source.replace /@@([a-zA-Z]+)/, (_, name) ->
      switch typeof value = locals[name]
        when 'string'
          "'#{value.replace(/\n/g, '\\n').replace("'", "\\'")}'"
        when 'function'
          "`#{value.toString()}`"
        when 'object'
          "`#{JSON.stringify(value)}`"
        else
          value
    coffee.compile(str)

exports.render = (source, options) ->
  exports.compile(source)(options)

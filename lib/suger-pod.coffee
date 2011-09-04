coffee = require 'coffee-script'

exports.compile = (source, _) ->
  (locals) ->
    str = source.replace /@@([a-zA-Z]+)/g, (_, name) ->
      switch typeof value = locals[name]
        when 'function'
          throw "Function should not be embeded: @@#{name}"
        when 'string'
          "'#{value.replace(/\n/g, '\\n').replace(/'/g, "\\'")}'"
        when 'object'
          "`#{JSON.stringify(value)}`"
        else
          value
    coffee.compile(str)

exports.render = (source, options) ->
  exports.compile(source)(options)

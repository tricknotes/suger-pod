coffee = require 'coffee-script'

exports.compileToCoffee = (source, locals) ->
  source.replace /@@([a-zA-Z]+)/g, (_, name) ->
    switch typeof value = locals[name]
      when 'function'
        if value.constructor == RegExp # node 0.4.x
          value.toString().replace(/\n/g, '\\n')
        else
          throw "Function should not be embeded: @@#{name}"
      when 'string'
        "'#{value.replace(/\n/g, '\\n').replace(/'/g, "\\'")}'"
      when 'object'
        switch value.constructor
          when Date
            "new Date('#{value}')"
          when RegExp # node 0.5.x
            escape(value.toString())
          else
            "`#{JSON.stringify(value)}`"
      else
        value

exports.compile = (source, _) ->
  (locals) ->
    coffee.compile(exports.compileToCoffee(source, locals))

exports.render = (source, options) ->
  exports.compile(source)(options)

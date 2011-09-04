coffee = require 'coffee-script'

exports.compile = (source, _) ->
  (locals) ->
    str = source.replace /@@([a-zA-Z]+)/g, (_, name) ->
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
    coffee.compile(str)

exports.render = (source, options) ->
  exports.compile(source)(options)

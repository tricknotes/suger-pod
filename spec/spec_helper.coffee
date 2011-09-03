require.paths.unshift './spec', './spec/lib', './lib'

exports.enclose = (source) ->
  """
  (function() {
  #{source}
  }).call(this);

  """

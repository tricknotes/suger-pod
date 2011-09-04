require.paths.unshift './spec', './lib'

exports.enclose = (source) ->
  """
  (function() {
  #{source}
  }).call(this);

  """

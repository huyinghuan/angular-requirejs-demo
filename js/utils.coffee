define ['lodash'], (_)->
  utils =
    convertBit: (value)->
      value = value / 1024 / 1024 / 1024
      value.toFixed(2)

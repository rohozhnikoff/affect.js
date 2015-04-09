isSameType = (x, y) ->
  if x is y
    return true

  typeofX = typeof x
  typeofY = typeof y

  if typeofX is typeofY
    if typeofX is 'object'
      if x is null and y is null
        return true
      else if x is null or y is null
        return false

      # checking for Object, Array, new String, new Boolean, new Number, new Date, RegExp, Error
      return x.constructor is y.constructor

    else if typeofX is 'number'
      # NaN !== NaN => true // fastest checking for NaN
      return !((x isnt x or y isnt y) and !(x isnt x and y isnt y))
    else
      return true
  else

    for constructor in [Number, String, Boolean]
      if x instanceof constructor
        return typeofY is typeof x.valueOf()
      else if y instanceof constructor
        return typeofX is typeof y.valueOf()

    return false

# todo: regexp also can be 'functions', in old browsers, but i am so lazy to write this usecase

module.exports = isSameType
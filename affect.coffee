isSameType = require('./issametype')

isArray = Array.isArray.bind(Array)

isObject = (x) -> typeof x is 'object' && x isnt null && !isArray(x)

isIterable = (x) -> isObject(x) || isArray(x)

isIterables = (x, y) -> isIterable(x) and isIterable(y)

getUniqKeysFromObjects = (l, r) ->
  Object.keys(l).concat(Object.keys(r)).reduce((memo, el) ->
    unless el in memo
      memo.push(el)
    return memo
  , [])

normalizePrimitive = do ->
  primitiveConstructors = [Number, String, Boolean]

  return (x) ->
    for constructor in primitiveConstructors
      if x instanceof constructor
        return x.valueOf()

    return x

affect = (l, r, pref) ->
  accum = []
  pref = if pref? then pref + '.' else ''

  if l is r
    return undefined

  else if isObject(l) and isObject(r)
    keys = getUniqKeysFromObjects(l, r)

    lHasOwnProperty = l.hasOwnProperty.bind(l)
    rHasOwnProperty = l.hasOwnProperty.bind(r)

    for key in keys
      lvalue = l[key]
      rvalue = r[key]

      lvalue = normalizePrimitive(lvalue) if typeof lvalue is 'object'
      rvalue = normalizePrimitive(rvalue) if typeof rvalue is 'object'

      newKey = pref + key

      if !isSameType(lvalue, rvalue)
        accum.push(newKey)
      else if (!lHasOwnProperty(key) or !rHasOwnProperty(key)) or (lvalue isnt rvalue)
        changes = if isIterables(lvalue, rvalue) then affect(lvalue, rvalue, newKey) else newKey
        accum = accum.concat(changes)

  else if isArray(l) and isArray(r)
    maxLength = Math.max(l.length, r.length)

    for i in [0..maxLength]
      lvalue = l[i]
      rvalue = r[i]

      lvalue = normalizePrimitive(l[i]) if typeof lvalue is 'object'
      rvalue = normalizePrimitive(r[i]) if typeof rvalue is 'object'

      newKey = [pref.slice(0, -1) + "[#{i}]"]

      if !isSameType(l, r)
        accum.push(newKey)

      else if lvalue isnt rvalue
        changes = if isIterables(lvalue, rvalue) then affect(lvalue, rvalue, newKey) else newKey
        accum = accum.concat(changes)

  return accum



module.exports = affect
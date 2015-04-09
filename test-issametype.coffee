isSameType = require('./issametype')


console.log('should be all FALSE:', [
  isSameType({}, [])
  isSameType({}, new Date())
  isSameType({}, null)
  isSameType({}, /fuck/gmi)
  isSameType({}, new RegExp(/fuck/gmi))
  isSameType({
    fuck: 'suck'
  }, new String('fuck'))
  isSameType({}, new Boolean(true))
  isSameType({}, new Number(1))
  isSameType(123, NaN)
  isSameType({}, new Error('fick'))
  isSameType(123, '123')
]);

console.log('should be all TRUE:', [
  isSameType(123, new Number(123))
  isSameType(new Date(), new Date())
  isSameType(NaN, NaN)
  isSameType(null, null)
  isSameType(true, new Boolean(true))
  isSameType(/fuck/gmi, new RegExp('fuck', 'gmi'))
  isSameType('fuck', new String('fuck'))
  isSameType({fuck: 234}, {fuck: 123})
  isSameType(new Function('a', 'b', 'return a + b'), (a, b) -> return a + b)
])
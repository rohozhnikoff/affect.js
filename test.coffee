affect = require('./affect')


left = {
  stringggg: new String('fuck')
  sss: ['fuck']
  hello: 'world'
  fuck: {
    mean: 3
    unchange: 'me'
    change: 'me'
    first: {
      second: {
        fuck: 'fuck'
        third: {
          fourth: 'string'
          changes: [
            {
              id: 1
            }
            {
              id: 2
            }
            {
              id: 3
              color: 'frrr'
            }
          ]
        }
      }
    }
  }
  arr: [
    1,
    2,
    3,
    4
  ]
}


right = {
  stringggg: 'fuck'
  sss: {
    fuck: 'suck'
  }
  hello: 'world2'
  fuck: {
    mean: '3'
    unchange: 'me'
    change: 'me2'
    first: {
      second: {
        fuck: 'fuck'
        third: {
          fourth: 'string'
          changes: [
            {
              id: 1
            }
            {
              id: 2
            }
            {
              id: 3
            }
          ]
        }
      }
    }
  }
  arr: [
    1,
    2,
    3
  ]
}

console.log affect(left, right)
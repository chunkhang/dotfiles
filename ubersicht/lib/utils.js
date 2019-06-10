import Duration from 'duration-js'

// Return duration in milliseconds
const duration = (string) => {
  return new Duration(string).milliseconds()
}

// Return url prefixed with proxy url
const url = (link) => {
  const proxyUrl = 'http://127.0.0.1:41417/'
  return `${proxyUrl}${link}`
}

// Return string with word pluralized based on quantity
const pluralize = (quantity, word) => {
  let string = `${quantity} ${word}`
  if (quantity > 1) {
    string += 's'
  }
  return string
}

export {
  duration,
  url,
  pluralize,
}

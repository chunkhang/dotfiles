import { css } from 'uebersicht'
import Duration from 'duration-js'

export const makeClasses = (styles) => {
  const classes = Object.entries(styles).reduce((acc, style) => {
    const [key, value] = style
    acc[key] = css(value)
    return acc
  }, {})
  return classes
}

export const updateState = (event, previousState) => {
  const { output } = event

  const data = {
    ...previousState.data,
    error: null,
  }

  if (output) {
    try {
      Object.assign(data, JSON.parse(output))
    } catch (error) {
      data.error = error.toString()
    }
  } else {
    data.error = 'No output found'
  }

  return { data }
}

// Return duration in milliseconds
export const duration = (string) => {
  return new Duration(string).milliseconds()
}

// Return url prefixed with proxy url
export const url = (link) => {
  const proxyUrl = 'http://127.0.0.1:41417/'
  return `${proxyUrl}${link}`
}

// Return string with word pluralized based on quantity
export const pluralize = (quantity, word) => {
  let string = `${quantity} ${word}`
  if (quantity > 1) {
    string += 's'
  }
  return string
}

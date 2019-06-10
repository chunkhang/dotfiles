import { run, css } from 'uebersicht'

import { duration, url } from '../lib/utils'
import styles from './src/styles'

const MAX_QUOTE_LENGTH = 65

const parseResponse = (response) => {
  return response.text().then((xml) => {
    const item = $(xml).find('item').eq(0)
    const quote = item.find('description').text().slice(1, -1)
    const author = item.find('title').text()
    return { quote, author }
  })
}

const command = (dispatch) => {
  const api = 'https://www.brainyquote.com/link/quotebr.rss'
  run('lib/scripts/wait-for-network.zsh').then(() => {
    fetch(url(api))
      .then((response) => {
        parseResponse(response).then(({ quote, author }) => {
          if (quote.length <= MAX_QUOTE_LENGTH) {
            dispatch({ type: 'SUCCESS', quote, author, error: null })
          } else {
            dispatch({ type: 'FAIL', error: null })
          }
        })
      })
      .catch((error) => {
        dispatch({ type: 'ERROR', error: String(error) })
      })
  })
}

const refreshFrequency = duration('1h')

const initialState = {
  quote: 'The unexamined life is not worth living.',
  author: 'Socrates',
  error: null,
}

const updateState = (event, prevState) => {
  const { type, quote, author } = event
  if (type === 'SUCCESS') {
    return {
      quote,
      author,
    }
  }
  if (type === 'FAIL') {
    return prevState
  }
  return initialState
}

const { className, ...s } = styles(css)

const render = (state) => {
  const { quote, author, error } = state
  return (
    <div>
      <div className="widget-name">Quote</div>
      <div className={s.quote}>{quote}</div>
      <div className={s.author}>{author}</div>
      {error}
    </div>
  )
}

export {
  command,
  refreshFrequency,
  initialState,
  updateState,
  className,
  render,
}

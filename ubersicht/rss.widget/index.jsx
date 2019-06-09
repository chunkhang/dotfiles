import { run, css } from 'uebersicht'

import { Container, Title } from '../lib/components'
import styles from './src/styles'

const FEEDS = [
  {
    title: 'BBC News',
    url: 'http://feeds.bbci.co.uk/news/world/rss.xml',
    limit: 5,
  },
  {
    title: 'The Star',
    url: 'http://www.thestar.com.my/rss/news/nation',
    limit: 5,
  },
  {
    title: 'Hacker News',
    url: 'https://hnrss.org/frontpage',
    limit: 5,
  },
  {
    title: 'Wired',
    url: 'https://www.wired.com/feed/rss',
    limit: 5,
  },
]

const parseFeed = (feed) => {
  const { title, url, limit } = feed
  const shell = 'zsh'
  const script = 'lib/scripts/parse_feed.py'
  const args = [title, url, limit].map(arg => `"${arg}"`).join(' ')
  const command = `${shell} -l -c '${script} ${args}'`
  return run(command)
}

const command = (dispatch) => {
  run('lib/scripts/wait-for-network.zsh').then(() => {
    FEEDS.forEach((feed, index) => {
      parseFeed(feed)
        .then((output) => {
          const entries = JSON.parse(output)
          if (entries.length > 0) {
            dispatch({ type: 'SUCCESS', index, entries })
          } else {
            dispatch({ type: 'FAIL' })
          }
        })
        .catch((error) => {
          dispatch({ type: 'ERROR', index, error })
        })
    })
  })
}

const refreshFrequency = 15 * 60 * 1000 // 15 minutes

const initialState = {
  feeds: FEEDS.map(feed => ({
    title: feed.title,
    link: feed.url,
    entries: [],
    error: null,
  })),
}

const updateFeed = (feeds, index, updates) => {
  return [
    ...feeds.slice(0, index),
    { ...feeds[index], ...updates },
    ...feeds.slice(index + 1),
  ]
}

const updateState = (event, prevState) => {
  const { type, index, entries, error } = event
  const { feeds } = prevState
  if (type === 'SUCCESS') {
    return {
      ...prevState,
      feeds: updateFeed(feeds, index, { entries, error: null }),
    }
  }
  if (type === 'FAIL') {
    return prevState
  }
  if (type === 'ERROR') {
    return {
      ...prevState,
      feeds: updateFeed(feeds, index, { error: String(error) }),
    }
  }
  return initialState
}

const { className, ...s } = styles(css)

const renderIcon = link => (
  <a
    href={link}
    style={{ color: 'white', textDecoration: 'none' }}
  >
    <i
      className="icon-link-ext"
      style={{ fontStyle: 'normal', fontSize: '10px' }}
    />
  </a>
)

const renderFeeds = feeds => (
  <ul className={s.feedList}>
    {feeds.map((feed, i) => (
      <li className={s.feedItem} key={i}>
        <div className={s.feedTitle}>
          {feed.title} {renderIcon(feed.link)}
        </div>
        <ul className={s.entryList}>
          {feed.entries.map((entry, j) => (
            <li className={s.entryItem} key={j}>
              {entry.title} {renderIcon(entry.link)}
            </li>
          ))}
        </ul>
        {feed.error}
      </li>
    ))}
  </ul>
)

const render = ({ feeds }) => (
  <div>
    <link rel="stylesheet" href="lib/css/fontello.css" />
    <Container>
      <Title>Feed</Title>
      {feeds.length > 0 ? renderFeeds(feeds) : (
        <div>Not available</div>
      )}
    </Container>
  </div>
)

module.exports = {
  command,
  refreshFrequency,
  initialState,
  updateState,
  className,
  render,
}

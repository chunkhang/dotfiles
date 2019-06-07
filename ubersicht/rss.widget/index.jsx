import { run, css } from 'uebersicht';
import { Container, Title } from '../lib/components';

const SHELL = 'zsh';
const FEEDS = {
  'BBC News': 'http://feeds.bbci.co.uk/news/world/rss.xml',
  'The Star': 'http://www.thestar.com.my/rss/news/nation',
  'Hacker News': 'https://hnrss.org/frontpage',
  // 'Wired': 'https://www.wired.com/feed'
};
const LIMIT = 5;

export const command = (dispatch) =>
  run('lib/scripts/wait-for-network.zsh').then(() => {
    // Prepare script with arguments
    let script = 'lib/scripts/parse_feed.py';
    const args = [LIMIT];
    const titles = Object.keys(FEEDS);
    const links = Object.values(FEEDS);
    for (let i = 0; i < titles.length; i++) {
      args.push(`"${titles[i]}"`);
      args.push(`"${links[i]}"`);
    }
    script = `${script} ${args.join(' ')}`;
    // Parse feed
    const command = `${SHELL} -l -c '${script}'`;
    run(command)
      .then((output) => {
        const feeds = JSON.parse(output);
        if (feeds.length > 0) {
          dispatch({ type: 'FETCH_SUCCEEDED', data: feeds });
        } else {
          dispatch({ type: 'FETCH_FAILED', data: feeds });
        }
      }).catch((error) => {
        dispatch({ type: 'FETCH_FAILED', error: error });
      });
  });

export const refreshFrequency = 15 * 60 * 1000; // 15 minutes

export const className = `
  top: 130px;
  left: 20px;
  width: 350px;
`;
const feedList = css`
  margin: 0;
  padding: 0;
  font-size: 12px;
  list-style: none;
  margin-top: 3px;
`;
const feedItem = css`
  margin-bottom: 5px;
`;
const feedTitle = css`
  font-weight: 400;
  margin-bottom: 2px;
`;
const entryList = css`
  margin: 0;
  padding: 0;
  font-size: 12px;
  padding-left: 16px;
`;
const entryItem = css`
  line-height: 1.1;
  margin-bottom: 1px;
  font-size: 11px;
`;

export const initialState = {
  feeds: []
};

export const render = ({ feeds }) => {
  return (
    <div>
      <link rel="stylesheet" href="lib/css/fontello.css" />
      <Container>
        <Title>Feed</Title>
        {feeds.length > 0 ? renderFeeds(feeds) : (
          <div>Not available</div>
        )}
      </Container>
    </div>
  );
};

const renderFeeds = (feeds) => {
  return (
    <ul className={feedList}>
      {feeds.map((feed, i) => (
        <li className={feedItem} key={i}>
          <div className={feedTitle}>
            {feed.title} {renderIcon(feed.link)}
          </div>
          <ul className={entryList}>
            {feed.entries.map((entry, j) => (
              <li className={entryItem} key={j}>
                {entry.title} {renderIcon(entry.link)}
              </li>
            ))}
          </ul>
        </li>
      ))}
    </ul>
  );
};

const renderIcon = (link) => {
  return (
    <a
      href={link}
      style={{ color: 'white', textDecoration: 'none' }}
    >
      <i
        className="icon-link-ext"
        style={{ fontStyle: 'normal', fontSize: '10px' }}>
      </i>
    </a>
  );
};

export const updateState = (event, previousState) => {
  switch (event.type) {
    case 'FETCH_SUCCEEDED': {
      return {
        feeds: event.data
      };
    }
    case 'FETCH_FAILED':
      return previousState;
    default:
      return initialState;
  }
};

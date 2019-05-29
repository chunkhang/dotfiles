import { run, css } from 'uebersicht';
import { Container, Title } from '../lib/components';

const PROXY_URL = 'http://127.0.0.1:41417/';
const API_URL = 'https://www.brainyquote.com/link/quotebr.rss';

export const command = (dispatch) =>
  run('lib/scripts/wait-for-network.zsh').then(() => {
    fetch(PROXY_URL + API_URL)
      .then((response) => {
        response.text().then((xml) => {
          dispatch({ type: 'FETCH_SUCCEEDED', data: xml });
        });
      })
      .catch((error) => {
        dispatch({ type: 'FETCH_FAILED', error: error });
      });
  });

export const refreshFrequency = 1 * 60 * 60 * 1000; // 1 hour

export const className = `
  top: 20px;
  left: 20px;
`;
const quoteStyle = css`
  line-height: 1;
`;
const authorStyle = css`
  font-size: 11px;
  margin-top: 1px;
`;

export const initialState = {
  quote: 'The unexamined life is not worth living.',
  author: 'Socrates'
};

export const render = ({ quote, author }) => {
  return (
    <Container>
      <Title>Quote</Title>
      <div className={quoteStyle}>{quote}</div>
      <div className={authorStyle}>{author}</div>
    </Container>
  );
};

export const updateState = (event, previousState) => {
  switch (event.type) {
    case 'FETCH_SUCCEEDED': {
      const quote = getQuote(event.data);
      if (quote.quote.length <= 65) {
        return quote;
      } else {
        return previousState;
      }
    }
    case 'FETCH_FAILED':
      return previousState;
    default:
      return initialState;
  }
};

const getQuote = (xml) => {
  const item = $(xml).find('item').eq(0);
  const quote = item.find('description').text().slice(1, -1);
  const author = item.find('title').text();
  return {
    quote,
    author
  };
};

import { React } from 'uebersicht';
import dayjs from 'dayjs';

import { duration, theme, makeClasses, updateState } from '../../lib';

const BIRTHDAY = '1996-02-14';
const DOT = '•';

const command = null;

const refreshFrequency = duration('1h');

const className = {
  ...theme.base,
  left: theme.paddings.x + 500,
  top: theme.paddings.y + 32,
};

const classes = makeClasses({
  title: {
    marginBottom: '1ch',
  },
  blocksContainer: {
    display: 'grid',
    gridTemplateColumns: 'repeat(2, 1fr)',
    gridGap: '0.5ch 1ch',
  },
  dotsContainer: {
    display: 'grid',
    gridTemplateColumns: 'repeat(26, 1fr)',
    gridGap: '0 0.25ch',
    lineHeight: 0.75,
  },
  dot: {
    width: '1ch',
    color: theme.colors.grey,
  },
});

const initialState = {};

function Block({ datetime }) {
  const dots = Array.from(Array(260).keys()).map((i) =>
    datetime.add(i, 'week'),
  );

  return (
    <div className={classes.dotsContainer}>
      {dots.map(() => (
        <div className={classes.dot}>{DOT}</div>
      ))}
    </div>
  );
}

const render = () => {
  const birthday = dayjs(BIRTHDAY, 'YYYY-MM-DD');

  const blocks = Array.from(Array(16).keys()).map((i) =>
    birthday.add(i, 'year'),
  );

  return (
    <div>
      <div className={classes.title}>LIFE</div>
      <div className={classes.blocksContainer}>
        {blocks.map((block) => (
          <Block datetime={block} />
        ))}
      </div>
    </div>
  );
};

export {
  command,
  refreshFrequency,
  className,
  initialState,
  updateState,
  render,
};

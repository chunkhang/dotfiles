import { React } from 'uebersicht';
import dayjs from 'dayjs';
import cx from 'classnames';

import { duration, theme, makeClasses, updateState } from '../../lib';

const BIRTHDAY = '1996-02-14';
const WEEKS_IN_YEAR = 52;
const TOTAL_YEARS = 80;
const DOT_SYMBOL = '·';
const DOT_SIZE = 1.25;

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
  dotsContainer: {
    display: 'grid',
    // Leave 2 extra items for vertical spacing and year count
    gridTemplateColumns: `repeat(${WEEKS_IN_YEAR + 2}, 1fr)`,
  },
  dot: {
    width: `${DOT_SIZE}ch`,
    height: `${DOT_SIZE}ch`,
    display: 'flex',
    justifyContent: 'left',
    alignItems: 'flex-start',
  },
  marginBottom: {
    marginBottom: '1ch',
  },
  fade: {
    color: theme.colors.grey,
  },
});

const initialState = {};

const render = () => {
  const birthday = dayjs(BIRTHDAY, 'YYYY-MM-DD');
  const now = dayjs();

  // Calculate based on assumption that each year has a constant number of weeks
  // If we get difference for week directly, the count will be off
  const yearsElapsed = now.diff(birthday, 'year', true);
  const weeksElapsed = Math.floor(yearsElapsed * WEEKS_IN_YEAR);

  const allWeeks = Array.from(Array(WEEKS_IN_YEAR * TOTAL_YEARS).keys());

  return (
    <div>
      <div className={classes.title}>LIFE</div>
      <div className={classes.dotsContainer}>
        {allWeeks.map((i) => {
          const count = i + 1;

          let extraElement = null;

          // Every 1/2 year, add vertical spacing
          if (count % (WEEKS_IN_YEAR / 2) === 0) {
            extraElement = <div className={classes.dot} />;
          }

          // Every 5 years, add year count
          if (count % (WEEKS_IN_YEAR * 5) === 0) {
            extraElement = (
              <div className={classes.dot}>
                {String(count / WEEKS_IN_YEAR).padStart(2, '0')}
              </div>
            );
          }

          return (
            <>
              <div
                className={cx({
                  [classes.dot]: true,
                  // Every 10 years, add horizontal spacing
                  [classes.marginBottom]: count % (WEEKS_IN_YEAR * 10) === 0,
                  // Fade out weeks that have not been lived yet
                  [classes.fade]: i >= weeksElapsed,
                })}
              >
                {DOT_SYMBOL}
              </div>
              {extraElement}
            </>
          );
        })}
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

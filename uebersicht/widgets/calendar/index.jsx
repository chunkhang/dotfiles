import { React } from 'uebersicht';
import { Calendar } from 'calendar';
import dayjs from 'dayjs';
import cx from 'classnames';

import { duration, theme, makeClasses, updateState } from '../../lib';

const WEEK_DAYS = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

const calendar = new Calendar();

const command = null;

const refreshFrequency = duration('1h');

const className = {
  ...theme.base,
  left: theme.paddings.x + 560,
  top: theme.paddings.y + 48,
};

const classes = makeClasses({
  title: {
    marginBottom: '1ch',
  },
  monthsContainer: {
    display: 'grid',
    gridTemplateColumns: 'repeat(3, 1fr)',
    gridGap: '2ch',
  },
  monthGridContainer: {
    lineHeight: 1,
  },
  monthGridRow: {
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
    marginTop: '1ch',
  },
  day: {
    width: '2ch',
    textAlign: 'right',
  },
  highlight: {
    color: theme.colors.red,
  },
  fade: {
    color: theme.colors.grey,
  },
});

const initialState = {};

function Month({ datetime }) {
  const weeks = calendar.monthDays(datetime.year(), datetime.month());

  const now = dayjs();
  const isCurrentMonth = now.isSame(datetime, 'month');
  const today = parseInt(now.format('D'), 10);

  return (
    <div>
      <div
        className={cx({
          [classes.highlight]: isCurrentMonth,
        })}
      >
        {datetime.format('MMM')}
      </div>
      <div className={classes.monthGridContainer}>
        <div className={classes.monthGridRow}>
          {WEEK_DAYS.map((weekDay) => (
            <div key={weekDay} className={classes.day}>
              {weekDay}
            </div>
          ))}
        </div>
        {weeks.map((week, i) => (
          <div key={i} className={classes.monthGridRow}>
            {week.map((day, j) => {
              const shouldHighlight = isCurrentMonth && day === today;
              const shouldFade = (j === 0 || j === 6) && !shouldHighlight;
              return (
                <div
                  key={j}
                  className={cx({
                    [classes.day]: true,
                    [classes.highlight]: shouldHighlight,
                    [classes.fade]: shouldFade,
                  })}
                >
                  {day || ''}
                </div>
              );
            })}
          </div>
        ))}
      </div>
    </div>
  );
}

const render = () => {
  const yearStart = dayjs().startOf('year');

  const months = Array.from(Array(12).keys()).map((i) =>
    yearStart.add(i, 'month'),
  );

  return (
    <div>
      <div className={classes.title}>CALENDAR</div>
      <div className={classes.monthsContainer}>
        {months.map((month) => (
          <div className={classes.month}>
            <Month datetime={month} />
          </div>
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

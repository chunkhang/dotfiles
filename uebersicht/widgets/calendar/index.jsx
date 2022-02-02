import { React } from 'uebersicht';
import { Calendar } from 'calendar';
import dayjs from 'dayjs';
import cx from 'classnames';

import { duration, theme, makeClasses, updateState } from '../../lib';

const WEEK_DAYS = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

const command = null;

const refreshFrequency = duration('1h');

const className = {
  ...theme.base,
  top: 40,
  right: 15,
  textAlign: 'right',
};

const classes = makeClasses({
  container: {
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
  },
  marginBottom: {
    marginBottom: '1ch',
  },
  day: {
    width: '2ch',
    textAlign: 'right',
  },
  highlight: {
    color: theme.colors.grey,
  },
});

const initialState = {};

function Month({ datetime }) {
  const calendar = new Calendar();
  const weeks = calendar.monthDays(datetime.year(), datetime.month());

  const now = dayjs();
  const isCurrentMonth = now.isSame(datetime, 'month');
  const today = parseInt(now.format('D'), 10);

  return (
    <div>
      <div className={classes.marginBottom}>{datetime.format('MMMM YYYY')}</div>
      <div className={cx([classes.container, classes.marginBottom])}>
        {WEEK_DAYS.map((weekDay) => (
          <div key={weekDay} className={classes.day}>
            {weekDay}
          </div>
        ))}
      </div>
      {weeks.map((week, i) => (
        <div key={i} className={cx([classes.container, classes.marginBottom])}>
          {week.map((day, j) => (
            <div
              key={j}
              className={cx({
                [classes.day]: true,
                [classes.highlight]: isCurrentMonth && day === today,
              })}
            >
              {day || ''}
            </div>
          ))}
        </div>
      ))}
    </div>
  );
}

const render = () => {
  const now = dayjs();

  return (
    <div>
      <div className={classes.marginBottom}>CALENDAR</div>
      <Month datetime={now} />
      <Month datetime={now.add(1, 'month')} />
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

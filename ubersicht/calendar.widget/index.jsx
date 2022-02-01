import { duration, makeClasses, updateState } from '../lib/utils';
import Calendar from './src/Calendar.jsx';
import Error from './src/Error.jsx';

const command = 'lib/scripts/get-calendar';

const refreshFrequency = duration('1h');

const className = {
  top: 35,
  right: 15,
};

const classes = makeClasses({
  mainContainer: {
    userSelect: 'none',
    cursor: 'default',
    textAlign: 'right',
  },
});

const render = ({ data }) => (
  <div className={classes.mainContainer}>
    <div className="widget-name">Calendar</div>
    <Calendar data={data} />
    <Error data={data} />
  </div>
);

const initialState = {
  data: {
    calendar: '',
    error: null,
  },
};

export {
  command,
  refreshFrequency,
  className,
  render,
  initialState,
  updateState,
};

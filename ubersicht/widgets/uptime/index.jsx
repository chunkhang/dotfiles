import { duration, pluralize } from '../../lib/utils';
import styles from './src/styles';

const command = 'uptime';

const refreshFrequency = duration('1m');

const initialState = {
  uptime: '',
};

const getMatch = (string, patterns) => {
  let matched = null;
  patterns.find((pattern) => {
    const match = string.match(pattern);
    if (match) {
      [, matched] = match;
      return true;
    }
    return false;
  });
  return matched;
};

const updateState = (event) => {
  const { output } = event;
  const uptimeString = output.match(/up (.+), \d+ users?/)[1];
  const regex = {
    day: [/(\d+) days?/],
    hour: [/(\d+):/, /(\d+) hrs?/],
    minute: [/:(\d+)/, /(\d+) mins?/],
  };
  const durations = Object.entries(regex).reduce(
    (acc, [key, patterns]) => ({
      ...acc,
      [key]: getMatch(uptimeString, patterns),
    }),
    {},
  );
  const maybeUptime = Object.entries(durations).reduce((acc, [key, value]) => {
    if (value) {
      return `${acc} ${pluralize(parseInt(value, 10), key)}`;
    }
    return acc;
  }, '');
  const uptime = maybeUptime || 'Not available';
  return { uptime };
};

const { className } = styles;

const render = (state) => {
  const { uptime } = state;
  return (
    <div>
      <div className="widget-name">Uptime</div>
      <div>{uptime}</div>
    </div>
  );
};

export {
  command,
  refreshFrequency,
  initialState,
  updateState,
  className,
  render,
};

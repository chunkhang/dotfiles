import { duration, theme, updateState, pluralize } from '../../lib';

const command = 'widgets/uptime/command';

const refreshFrequency = duration('1m');

const className = {
  ...theme.base,
  right: theme.paddings.x,
  top: theme.paddings.y + 32,
  textAlign: 'right',
};

const initialState = {
  uptime: '',
  error: null,
};

const formatUptime = (uptime) => {
  const mainMatch = uptime.match(/up (.+), \d+ user/);
  if (!mainMatch) return null;

  const main = mainMatch[1];

  const durationRegex = [
    { unit: 'day', patterns: [/(\d+) days?/] },
    { unit: 'hour', patterns: [/(\d+):/, /(\d+) hrs?/] },
    { unit: 'minute', patterns: [/:(\d+)/, /(\d+) mins?/] },
  ];

  const durations = [];

  durationRegex.forEach(({ unit, patterns }) => {
    let value;

    patterns.find((pattern) => {
      const valueMatch = main.match(pattern);
      if (!valueMatch) return false;

      value = parseInt(valueMatch[1], 10);
      return true;
    });

    if (!value) return;

    durations.push(pluralize(unit, value));
  });

  return durations.join(' ');
};

const render = ({ uptime, error }) => {
  if (error) return null;

  return (
    <div>
      <div style={{ marginBottom: '1ch' }}>UPTIME</div>
      <div>{formatUptime(uptime) || 'Not available'}</div>
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

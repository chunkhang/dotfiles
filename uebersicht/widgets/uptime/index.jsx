import { duration, theme, updateState, pluralize } from '../../lib';

const command = 'widgets/uptime/command';

const refreshFrequency = duration('1m');

const className = {
  ...theme.base,
  top: 40,
  left: 15,
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
      <div style={{ marginBottom: '2ch' }}>{formatUptime(uptime)}</div>
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

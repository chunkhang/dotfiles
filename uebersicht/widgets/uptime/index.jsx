import { duration, theme, updateState, pluralize } from '../../lib';

const command = 'widgets/uptime/command';

const refreshFrequency = duration('1m');

const className = {
  ...theme.base,
  left: theme.paddings.x + 1088,
  top: theme.paddings.y + 40,
};

const initialState = {
  uptime: '',
  error: null,
};

const render = ({ uptime, error }) => {
  if (error) return null;

  return (
    <div>
      <div style={{ marginBottom: '1ch' }}>UPTIME</div>
      <div>{uptime || 'Not available'}</div>
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

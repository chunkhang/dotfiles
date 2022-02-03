import { duration, theme, updateState } from '../../lib';

const command = 'widgets/ip/command';

const refreshFrequency = duration('5s');

const className = {
  ...theme.base,
  top: 96,
  left: 15,
};

const initialState = {
  ip: '',
  error: null,
};

const render = ({ ip, error }) => {
  if (error) return null;

  return (
    <div>
      <div style={{ marginBottom: '1ch' }}>LOCAL IP</div>
      <div>{ip || 'Not available'}</div>
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

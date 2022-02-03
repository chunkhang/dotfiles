import dayjs from 'dayjs';

import { duration, theme, makeClasses, updateState } from '../../lib';

const command = 'widgets/status/command';

const refreshFrequency = duration('5s');

const className = {
  ...theme.base,
  top: 8,
  right: 15,
};

const classes = makeClasses({
  container: {
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
  },
});

function Bluetooth({ device, active }) {
  const style = {};
  if (!active) {
    style.color = theme.colors.grey;
  }

  return (
    <div className={classes.container}>
      <i className="icon-bluetooth" style={style} />
      {device ? <div>{device}</div> : null}
    </div>
  );
}

function Wifi({ ssid, active }) {
  const style = {};
  if (!active) {
    style.color = theme.colors.grey;
  }

  return (
    <div className={classes.container}>
      <i className="icon-wifi" style={style} />
      {ssid ? <div>{ssid}</div> : null}
    </div>
  );
}

function Battery({ percent, using, charging }) {
  const level = Math.ceil(percent / 25);
  const iconName = using ? `icon-battery-${level}` : 'icon-plug';

  return (
    <div className={classes.container}>
      <i className={iconName} />
      <div>
        <span>{percent}%</span>
        {charging ? <span>+</span> : null}
      </div>
    </div>
  );
}

function DateTime() {
  const now = dayjs();

  return <div>{now.format('ddd DD/MM HH:mm')}</div>;
}

const initialState = {
  battery: {
    percent: 100,
    using: 0,
    charging: 0,
  },
  wifi: {
    ssid: '',
    active: 0,
  },
  bluetooth: {
    device: '',
    active: 0,
  },
  error: null,
};

const render = ({ battery, wifi, bluetooth, error }) => {
  if (error) return null;

  return (
    <div className={classes.container}>
      <Bluetooth device={bluetooth.device} active={bluetooth.active} />
      <div>{theme.elements.divider}</div>
      <Wifi ssid={wifi.ssid} active={wifi.active} />
      <div>{theme.elements.divider}</div>
      <Battery
        percent={battery.percent}
        using={battery.using}
        charging={battery.charging}
      />
      <div>{theme.elements.divider}</div>
      <DateTime />
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

import dayjs from 'dayjs';

import { duration, theme, makeClasses, updateState } from '../../lib';

const command = 'widgets/status/command';

const refreshFrequency = duration('5s');

const className = {
  ...theme.base,
  right: theme.paddings.x,
  top: theme.paddings.y,
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

function Language({ lang }) {
  return (
    <div className={classes.container}>
      <i className="icon-globe-alt" />
      <div>{lang.toUpperCase()}</div>
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

  return (
    <div className={classes.container}>
      <i className="icon-calendar" />
      <div>{now.format('ddd DD/MM HH:mm')}</div>
    </div>
  );
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
  lang: 'en',
  error: null,
};

const render = ({ battery, wifi, bluetooth, lang, error }) => {
  if (error) return null;

  return (
    <div className={classes.container}>
      <Bluetooth device={bluetooth.device} active={bluetooth.active} />
      <div> </div>
      <Wifi ssid={wifi.ssid} active={wifi.active} />
      <div> </div>
      <Language lang={lang} />
      <div> </div>
      <Battery
        percent={battery.percent}
        using={battery.using}
        charging={battery.charging}
      />
      <div> </div>
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

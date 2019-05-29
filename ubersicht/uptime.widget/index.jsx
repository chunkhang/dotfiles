import { Container, Title } from '../lib/components';

const config = {
  units: ['day', 'hour', 'minute'],
  pluralize: true
};

export const command = 'uptime';

export const refreshFrequency = 1 * 60 * 1000; // 1 minute

export const className = `
  top: 20px;
  right: 20px;
  text-align: right;
`;

export const initialState = {
  ip: ''
};

export const render = ({ uptime }) => {
  return (
    <Container>
      <Title>Uptime</Title>
      <div>{uptime}</div>
    </Container>
  );
};

export const updateState = (event) => {
  // Get raw uptime
  const rawRegex = /up (.+), \d+ users?/;
  const rawUptime = event.output.match(rawRegex)[1];

  // Possible raw uptimes:
  // '1 min', '2 mins'
  // '1 hr', '2 hrs'
  // '1 day', '2 days'
  // ' 3:01', '13:10'
  // '1 day, 1 min', '2 days, 1 hour', '1 day,  3:01', ...
  const dayRegex = /(\d+) days?/;
  const hourRegex = /(\d+):|(\d+) hrs?/;
  const minuteRegex = /:(\d+)|(\d+) mins?/;

  const durations = {
    day: 0,
    hour: 0,
    minute: 0
  };

  // Get day if any
  if (dayRegex.test(rawUptime)) {
    durations.day = parseInt(rawUptime.match(dayRegex)[1]);
  }

  // Get hour if any
  if (hourRegex.test(rawUptime)) {
    if (hourRegex.test(rawUptime)) {
      for (let group = 1; group <= 2; group++) {
        const match = rawUptime.match(hourRegex)[group];
        if (typeof(match) !== 'undefined') {
          durations.hour = parseInt(match);
        }
      }
    }
  }

  // Get minute if any
  if (minuteRegex.test(rawUptime)) {
    for (let group = 1; group <= 2; group++) {
      const match = rawUptime.match(minuteRegex)[group];
      if (typeof(match) !== 'undefined') {
        durations.minute = parseInt(match);
      }
    }
  }

  // Format uptime
  let uptime = '';
  Object.values(durations).forEach((duration, index) => {
    if (duration > 0) {
      const timeString = durationString(
        duration, config.units[index], config.pluralize);
      uptime += ` ${timeString}`;
    }
  });
  uptime = uptime.trim();
  if (!uptime) {
    uptime = 'Not available';
  }

  return {
    uptime
  };
};

function durationString(quantity, word, pluralize) {
  let string = `${quantity} ${word}`;
  if (pluralize && quantity > 1) {
    string += 's';
  }
  return string;
}

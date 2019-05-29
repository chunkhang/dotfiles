import { Container, Title } from '../lib/components';

export const command = 'lib/scripts/get-ssid.zsh';

export const refreshFrequency = 5 * 1000; // 5 seconds

export const className = `
  top: 65px;
  right: 20px;
  text-align: right;
`;

export const initialState = {
  ssid: ''
};

export const render = ({ ssid }) => {
  return (
    <Container>
      <Title>Wifi</Title>
      <div>{ssid}</div>
    </Container>
  );
};

export const updateState = (event) => {
  let ssid = 'Disabled';
  if (event.output) {
    const string = event.output.trim();
    if (string) {
      ssid = string;
    } else {
      ssid = 'No connection';
    }
  }
  return {
    ssid
  };
};

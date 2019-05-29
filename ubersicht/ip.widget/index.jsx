import { Container, Title } from '../lib/components';

export const command = 'lib/scripts/get-ip.zsh';

export const refreshFrequency = 5 * 1000; // 5 seconds

export const className = `
  top: 110px;
  right: 20px;
  text-align: right;
`;

export const initialState = {
  ip: ''
};

export const render = ({ ip }) => {
  return (
    <Container>
      <Title>Local IP</Title>
      <div>{ip}</div>
    </Container>
  );
};

export const updateState = (event) => {
  const ip = event.output ? event.output : 'Not available';
  return {
    ip
  };
};

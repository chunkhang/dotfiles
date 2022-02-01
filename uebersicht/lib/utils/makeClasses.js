import { css } from 'uebersicht';

const makeClasses = (styles) => {
  const classes = Object.entries(styles).reduce((acc, style) => {
    const [key, value] = style;
    acc[key] = css(value);
    return acc;
  }, {});
  return classes;
};

export default makeClasses;

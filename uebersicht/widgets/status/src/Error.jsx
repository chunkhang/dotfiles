import { makeClasses } from '../../../lib/utils';
import theme from '../../../lib/theme';

const classes = makeClasses({
  mainContainer: {
    color: theme.colors.red,
  },
});

function Error({ data }) {
  const { error } = data;

  if (!error) return null;

  return <div className={classes.mainContainer}>{error}</div>;
}

export default Error;

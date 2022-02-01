import moment from 'moment';

import { makeClasses } from '../../lib/utils';
import theme from '../../lib/theme';

const classes = makeClasses({
  mainContainer: {
    fontFamily: theme.font.family,
    fontSize: theme.font.size,
    color: theme.colors.white,
  },
});

function DateTime({ data }) {
  const { datetime } = data;

  if (!datetime) return null;

  return (
    <div className={classes.mainContainer}>
      {moment(datetime).format('ddd DD/MM HH:mm')}
    </div>
  );
}

export default DateTime;

import { React } from 'uebersicht';

import { makeClasses } from '../../lib/utils';
import theme from '../../lib/theme';

const classes = makeClasses({
  mainContainer: {
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
  },

  space: {
    color: theme.colors.grey,
  },

  label: {
    marginLeft: '1ch',
  },
});

function Divider() {
  return <div>|</div>;
}

function Space({ space }) {
  const { index, label, 'has-focus': focused, windows } = space;

  const hasWindows = windows.length > 0;

  const style = {};
  if (focused) {
    style.color = theme.colors.white;
  }

  return (
    <div className={classes.space} style={style}>
      <span>{index}</span>
      <span>{hasWindows ? '+' : null}</span>
      {label ? <span className={classes.label}>{label}</span> : null}
    </div>
  );
}

function Spaces({ data }) {
  const { spaces } = data;

  if (!spaces || spaces.length === 0) {
    return null;
  }

  return (
    <div className={classes.mainContainer}>
      {spaces.map((space, i) => (
        <React.Fragment key={i}>
          {i > 0 ? <Divider /> : null}
          <Space space={space} />
        </React.Fragment>
      ))}
    </div>
  );
}

export default Spaces;

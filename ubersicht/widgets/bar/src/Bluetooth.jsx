import { makeClasses } from '../../../lib/utils';
import theme from '../../../lib/theme';

const classes = makeClasses({
  mainContainer: {
    fontFamily: theme.font.family,
    fontSize: theme.font.size,
    color: theme.colors.white,
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
  },
});

function Bluetooth({ data }) {
  const { bluetooth } = data;

  if (!bluetooth) return null;

  const { active, device } = bluetooth;

  const iconStyle = {};
  if (!active) {
    iconStyle.color = theme.colors.grey;
  }

  return (
    <div className={classes.mainContainer}>
      <i className="icon-bluetooth-b" style={iconStyle} />
      {device}
    </div>
  );
}

export default Bluetooth;

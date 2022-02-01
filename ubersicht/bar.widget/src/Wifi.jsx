import { makeClasses } from '../../lib/utils';
import theme from '../../lib/theme';

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

function Wifi({ data }) {
  const { wifi } = data;

  if (!wifi) return null;

  const { ssid, active } = wifi;

  const iconStyle = {};
  if (!active) {
    iconStyle.color = theme.colors.grey;
  }

  return (
    <div className={classes.mainContainer}>
      <i className="icon-wifi" style={iconStyle} />
      {ssid}
    </div>
  );
}

export default Wifi;

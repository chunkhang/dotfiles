import { makeClasses } from '../../lib/utils'
import theme from '../../lib/theme'

const classes = makeClasses({
  mainContainer: {
    fontFamily: theme.font.family,
    fontSize: theme.font.size,
    color: theme.colors.white,
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
  },
})

const Battery = ({ data }) => {
  const { battery } = data

  if (!battery) {
    return (
      <div>No battery</div>
    )
  }

  const { percent, using, charging } = battery

  const iconName = using ? 'icon-battery-4' : 'icon-flash'

  return (
    <div className={classes.mainContainer}>
      <i className={iconName} />
      {percent}%{charging ? '+' : ''}
    </div>
  )
}

export default Battery

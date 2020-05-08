import { makeClasses } from './utils'
import theme from './theme'

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

const levels = {
  0: theme.colors.red,
  1: theme.colors.yellow,
  2: theme.colors.white,
  3: theme.colors.white,
  4: theme.colors.white,
}

const Battery = ({ data }) => {
  const { battery } = data

  if (!battery) {
    return (
      <div>No battery</div>
    )
  }

  const { percent, charging } = battery

  const level = Math.floor(percent / 25)
  const iconName = charging ? 'icon-flash' : `icon-battery-${level}`

  const iconStyle = {
    color: levels[level],
  }

  return (
    <div className={classes.mainContainer}>
      <i
        className={iconName}
        style={iconStyle}
      />
      {percent}%
    </div>
  )
}

export default Battery

import { makeClasses } from '../lib/utils'
import theme from '../lib/theme'

const refreshFrequency = false

const className = {
  top: 0,
  left: 0,
  right: 0,
}

const classes = makeClasses({
  mainContainer: {
    height: 32,
    position: 'fixed',
    width: '100%',
    zIndex: -1,
    // backgroundColor: theme.colors.black,
  },
})

const render = () => {
  return (
    <div className={classes.mainContainer} />
  )
}

export {
  refreshFrequency,
  className,
  render,
}

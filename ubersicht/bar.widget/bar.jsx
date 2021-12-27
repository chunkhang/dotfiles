import { makeClasses } from '../lib/utils'

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

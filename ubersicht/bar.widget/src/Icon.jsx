import { makeClasses } from './utils'
import theme from './theme'

const classes = makeClasses({
  mainContainer: {
    backgroundColor: theme.colors.blue,
    color: theme.colors.black,
    display: 'flex',
    justifyContent: 'center',
    width: '4ch',
  },
})

const Icon = ({ data }) => {
  const { icon } = data

  if (!icon) return null

  return (
    <div className={classes.mainContainer}>
      <i className={icon} />
    </div>
  )
}

export default Icon

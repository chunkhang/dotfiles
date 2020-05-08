import { makeClasses } from './utils'
import theme from './theme'

const classes = makeClasses({
  mainContainer: {
    color: theme.colors.red,
  },
})

const Error = ({ data }) => {
  const { error } = data

  if (!error) return null

  return (
    <div className={classes.mainContainer}>
      {error}
    </div>
  )
}

export default Error

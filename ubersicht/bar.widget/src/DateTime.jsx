import moment from 'moment'

import { makeClasses } from './utils'
import theme from './theme'

const classes = makeClasses({
  mainContainer: {
    fontFamily: theme.font.family,
    fontSize: theme.font.size,
    color: theme.colors.white,
  },
})

const DateTime = ({ data }) => {
  const { datetime } = data

  if (!datetime) return null

  return (
    <div className={classes.mainContainer}>
      {moment(datetime).format('ddd DD/MM HH:mm')}
    </div>
  )
}

export default DateTime

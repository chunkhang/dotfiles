import { makeClasses, updateState } from '../lib/utils'
import theme from '../lib/theme'

import Spaces from './src/Spaces.jsx'
import Error from './src/Error.jsx'

const command = 'lib/scripts/get-spaces'

const refreshFrequency = false

const className = {
  top: 8,
  left: 15,
  userSelect: 'none',
  cursor: 'default',
}

const classes = makeClasses({
  mainContainer: {
    height: 15,
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
    fontFamily: theme.font.family,
    fontSize: theme.font.size,
    color: theme.colors.white,
  },
})

const render = ({ data }) => {
  return (
    <div className={classes.mainContainer}>
      <Spaces data={data} />
      <Error data={data} />
    </div>
  )
}

const initialState = {
  data: {
    spaces: [],
    error: null,
  },
}

export {
  command,
  refreshFrequency,
  className,
  render,
  initialState,
  updateState,
}

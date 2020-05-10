import Icon from './src/Icon.jsx'
import Spaces from './src/Spaces.jsx'
import Error from './src/Error.jsx'
import { makeClasses, updateState } from './src/utils'
import theme from './src/theme'

const command = 'lib/scripts/get-spaces'

const refreshFrequency = false

const className = {
  top: 4,
  left: 15,
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
      <Icon data={data} />
      <Spaces data={data} />
      <Error data={data} />
    </div>
  )
}

const initialState = {
  data: {
    icon: 'icon-apple',
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

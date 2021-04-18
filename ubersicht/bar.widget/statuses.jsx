import { duration } from '../lib/utils'

import Error from './src/Error.jsx'
import Bluetooth from './src/Bluetooth.jsx'
import Wifi from './src/Wifi.jsx'
import Battery from './src/Battery.jsx'
import DateTime from './src/DateTime.jsx'
import { makeClasses, updateState } from '../lib/utils'
import theme from '../lib/theme'

const command = 'lib/scripts/get-statuses'

const refreshFrequency = duration('5s')

const className = {
  top: 4,
  right: 15,
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

const Divider = () => {
  return (
    <div>|</div>
  )
}

const render = ({ data }) => {
  return (
    <div className={classes.mainContainer}>
      <Error data={data} />
      <Bluetooth data={data} />
      <Divider />
      <Wifi data={data} />
      <Divider />
      <Battery data={data} />
      <Divider />
      <DateTime data={data} />
    </div>
  )
}

const initialState = {
  data: {
    datetime: '',
    battery: {
      percent: 100,
      charging: 0,
    },
    wifi: {
      ssid: '',
      active: 0,
    },
    bluetooth: {
      device: '',
      active: 0,
    },
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

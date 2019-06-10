import { duration } from '../lib/utils'
import styles from './src/styles'

const command = 'lib/scripts/get-ssid.zsh'

const refreshFrequency = duration('5s')

const initialState = {
  ssid: '',
}

const updateState = (event) => {
  const { output } = event
  let ssid = 'Disabled'
  if (output) {
    const trimmed = output.trim()
    ssid = trimmed ? trimmed : 'No connection'
  }
  return { ssid }
}

const { className } = styles

const render = (state) => {
  const { ssid } = state
  return (
    <div>
      <div className="widget-name">Wifi</div>
      <div>{ssid}</div>
    </div>
  )
}

export {
  command,
  refreshFrequency,
  initialState,
  updateState,
  className,
  render,
}

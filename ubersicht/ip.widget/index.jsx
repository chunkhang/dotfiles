import { duration } from '../lib/utils'
import styles from './src/styles'

const command = 'lib/scripts/get-ip'

const refreshFrequency = duration('5s')

const initialState = {
  ip: '',
}

const { className } = styles

const render = (state) => {
  const { ip } = state
  return (
    <div>
      <div className="widget-name">Local IP</div>
      <div>{ip}</div>
    </div>
  )
}

const updateState = (event) => {
  const { output } = event
  const ip = output || 'Not available'
  return { ip }
}

export {
  command,
  refreshFrequency,
  initialState,
  updateState,
  className,
  render,
}

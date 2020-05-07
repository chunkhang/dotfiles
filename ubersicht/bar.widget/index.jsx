import { css } from 'uebersicht'

import styles from './src/styles'

const command = 'lib/scripts/get-spaces.zsh'

const refreshFrequency = false

const initialState = {
  spaces: null,
}

const { className, ...s } = styles(css)

const renderSpace = (space) => {
  const {
    id,
    index,
    focused,
    windows,
  } = space

  const hasWindows = windows.length > 0

  const style = {}
  if (focused) {
    style.backgroundColor = '#3e4452'
  }

  return (
    <div
      key={id}
      className={s.spaceContainer}
      style={style}
    >
      <span>&nbsp;</span>
      <span>{index}</span>
      <span>{hasWindows ? '+' : null}</span>
      <span>&nbsp;</span>
    </div>
  )
}

const render = (state) => {
  const { spaces } = state

  return (
    <div className={s.mainContainer}>
      <link rel="stylesheet" href="lib/css/fontello.css" />
      <div className={s.barContainer}>
        <div className={s.iconContainer}>
          <span>&nbsp;</span>
          <i className="icon-apple" />
          <span>&nbsp;</span>
        </div>
        {spaces ? (
          <div className={s.spacesContainer}>
            {spaces.map(space => renderSpace(space))}
          </div>
        ) : null}
      </div>
    </div>
  )
}

const updateState = (event) => {
  const { output } = event

  let spaces = null

  if (output) {
    try {
      spaces = JSON.parse(output)
    } catch (error) {
      spaces = error.toString()
    }
  }

  return { spaces }
}

export {
  command,
  refreshFrequency,
  initialState,
  updateState,
  className,
  render,
}

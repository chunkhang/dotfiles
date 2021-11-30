import { makeClasses } from '../../lib/utils'
import theme from '../../lib/theme'

const classes = makeClasses({
  mainContainer: {
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
  },

  space: {
    padding: '0 1ch',
  },

  label: {
    marginLeft: '1ch',
  },
})

const Space = ({ space }) => {
  const { id, index, label, 'has-focus': focused, windows } = space

  const hasWindows = windows.length > 0

  const style = {}
  if (focused) {
    style.backgroundColor = theme.colors.grey
  }

  return (
    <div
      key={id}
      className={classes.space}
      style={style}
    >
      <span>{index}</span>
      {label ? (
        <span className={classes.label}>
          {label}
        </span>
      ) : null}
      <span>{hasWindows ? '+' : null}</span>
    </div>
  )
}

const Spaces = ({ data }) => {
  const { spaces } = data

  if (!spaces || spaces.length === 0) {
    return null
  }

  return (
    <div className={classes.mainContainer}>
      {spaces.map((space, i) => (
        <Space key={i} space={space} />
      ))}
    </div>
  )
}

export default Spaces

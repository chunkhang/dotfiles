import { React } from 'uebersicht';

import { theme, makeClasses, updateState } from '../../lib';

const command = 'widgets/space/command';

const refreshFrequency = false;

const className = {
  ...theme.base,
  left: theme.paddings.x,
  top: theme.paddings.y,
};

const classes = makeClasses({
  container: {
    display: 'grid',
    gridAutoFlow: 'column',
    gridGap: '1ch',
  },
});

function Space({ index, focused, windows }) {
  const style = {};
  if (!focused) {
    style.color = theme.colors.grey;
  }

  return (
    <div style={style}>
      <span>{index}</span>
      {windows.length > 0 ? <span>+</span> : null}
    </div>
  );
}

const initialState = {
  spaces: [],
  error: null,
};

const render = ({ spaces, error }) => {
  if (error) return null;

  if (spaces.length === 0) return null;

  return (
    <div className={classes.container}>
      {spaces.map((space, i) => (
        <React.Fragment key={i}>
          {i > 0 ? <div>{theme.elements.divider}</div> : null}
          <Space
            index={space.index}
            focused={space['has-focus']}
            windows={space.windows}
          />
        </React.Fragment>
      ))}
    </div>
  );
};

export {
  command,
  refreshFrequency,
  className,
  initialState,
  updateState,
  render,
};
const styles = css => ({
  className: {
    left: 0,
    right: 0,
  },

  mainContainer: css({
    boxSizing: 'border-box',
    height: 19,
    paddingLeft: 15,
    paddingTop: 2,
    fontSize: 12,
    fontFamily: 'MesloLGS Nerd Font',
    backgroundColor: '#282c34',
    color: '#abb2bf',
  }),

  barContainer: css({
    height: 15,
    display: 'flex',
  }),

  iconContainer: css({
    backgroundColor: '#61afef',
    color: '#282c34',
    marginRight: '1ch',
    width: '4ch',
  }),

  spacesContainer: css({
    display: 'flex',
  }),

  spaceContainer: css({
    marginRight: '1ch',
  }),
})

export default styles

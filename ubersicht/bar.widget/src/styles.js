const styles = css => ({
  className: {
    left: 0,
    right: 0,
  },

  mainContainer: css({
    boxSizing: 'border-box',
    height: 23,
    display: 'flex',
    alignItems: 'center',
    paddingLeft: 15,
    fontSize: 12,
    fontFamily: 'Meslo LG S for Powerline',
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
    display: 'flex',
    justifyContent: 'center',
    width: '4ch',
    marginRight: '1ch',
  }),

  spacesContainer: css({
    display: 'flex',
  }),

  spaceContainer: css({
    marginRight: '1ch',
  }),
})

export default styles

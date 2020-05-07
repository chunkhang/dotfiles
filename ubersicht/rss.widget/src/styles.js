const styles = css => ({
  className: {
    top: 30,
    left: 20,
    width: 350,
  },

  feedList: css({
    margin: 0,
    padding: 0,
    fontSize: 12,
    listStyle: 'none',
    marginTop: 3,
  }),

  feedItem: css({
    marginBottom: 5,
  }),

  feedTitle: css({
    fontWeight: '400',
    marginBottom: 2,
  }),

  entryList: css({
    margin: 0,
    padding: 0,
    fontSize: 12,
    paddingLeft: 16,
  }),

  entryItem: css({
    lineHeight: '1.1',
    marginBottom: 1,
    fontSize: 11,
  }),

  linkIcon: css({
    fontStyle: 'normal',
    fontSize: 10,
  }),
})

export default styles

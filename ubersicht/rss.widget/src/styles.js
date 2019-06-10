const styles = css => ({
  className: {
    top: '130px',
    left: '20px',
    width: '350px',
  },

  feedList: css({
    margin: 0,
    padding: 0,
    fontSize: '12px',
    listStyle: 'none',
    marginTop: '3px',
  }),

  feedItem: css({
    marginBottom: '5px',
  }),

  feedTitle: css({
    fontWeight: '400',
    marginBottom: '2px',
  }),

  entryList: css({
    margin: 0,
    padding: 0,
    fontSize: '12px',
    paddingLeft: '16px',
  }),

  entryItem: css({
    lineHeight: '1.1',
    marginBottom: '1px',
    fontSize: '11px',
  }),

  linkIcon: css({
    fontStyle: 'normal',
    fontSize: '10px',
  }),
})

export default styles

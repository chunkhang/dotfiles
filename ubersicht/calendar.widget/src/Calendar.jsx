import cx from 'classnames'

import { makeClasses } from '../../lib/utils'
import theme from '../../lib/theme'

const WEEKDAYS = [
  'Su',
  'Mo',
  'Tu',
  'We',
  'Th',
  'Fr',
  'Sa',
]

const CELL_SPACING = 6

const classes = makeClasses({
  mainContainer: {
    marginTop: 12,
  },

  table: {
    borderCollapse: 'separate',
    borderSpacing: CELL_SPACING,
    margin: -CELL_SPACING,
  },

  cell: {
    fontSize: 12,
  },

  sunday: {
    color: theme.colors.red,
  },

  today: {
    color: theme.colors.blue,
  },
})

const Calendar = ({ data }) => {
  const { calendar, error } = data

  if (!calendar || error) return null

  // Parse calendar rows into array of weeks
  // [
  //   ['1', '2', '3'],
  //   ['4', '5', '6', '7', '8', '9', '10'],
  //   ...
  //   ['25', '26', '27', '28', '29', '30']
  // ]
  const rows = calendar.trim().split('\n')
  const weeks = rows.map((row) => {
    return row.split(/\s+/).filter(day => !!day)
  })

  // Pad first and last week arrays
  const firstWeek = weeks[0]
  if (firstWeek.length < 7) {
    weeks[0] = [
      ...Array.from(Array(7 - firstWeek.length)),
      ...firstWeek,
    ]
  }
  const lastIndex = weeks.length - 1
  const lastWeek = weeks[lastIndex]
  if (lastWeek.length < 7) {
    weeks[lastIndex] = [
      ...lastWeek,
      ...Array.from(Array(7 - lastWeek.length)),
    ]
  }

  const today = new Date().getDate()

  return (
    <div className={classes.mainContainer}>
      <table className={classes.table}>
        <thead>
          <tr>
            {WEEKDAYS.map((weekday, i) => {
              return (
                <td
                  key={i}
                  className={cx({
                    [classes.cell]: true,
                    [classes.sunday]: i === 0,
                  })}
                >
                  {weekday}
                </td>
              )
            })}
          </tr>
        </thead>
        <tbody>
          {weeks.map((week, i) => {
            return (
              <tr key={i}>
                {week.map((day, j) => {
                  const isToday = day && parseInt(day, 10) === today
                  return (
                    <td
                      key={j}
                      className={cx({
                        [classes.cell]: true,
                        [classes.day]: true,
                        [classes.today]: isToday,
                      })}
                    >
                      {day}
                    </td>
                  )
                })}
              </tr>
            )
          })}
        </tbody>
      </table>
    </div>
  )
}

export default Calendar

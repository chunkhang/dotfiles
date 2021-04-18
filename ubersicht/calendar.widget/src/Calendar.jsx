import cx from 'classnames'
import moment from 'moment'

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
    marginTop: 8,
  },

  monthContainer: {
    marginBottom: 8,
  },

  title: {
    marginBottom: 4,
    fontWeight: 500,
    fontSize: 10,
    textTransform: 'uppercase',
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

const Month = ({ date, data }) => {
  const title = date.format('MMMM YYYY')

  // Parse month data into array of weeks
  // [
  //   ['1', '2', '3'],
  //   ['4', '5', '6', '7', '8', '9', '10'],
  //   ...
  //   ['25', '26', '27', '28', '29', '30']
  // ]
  const rows = data.trim().split('\n')
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

  // Highlight today in calendar
  const hasToday = moment().isSame(date, 'month')
  const today = date.format('DD')

  return (
    <div className={classes.monthContainer}>
      <div className={classes.title}>{title}</div>
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
                  const isToday = hasToday && day === today
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

const Calendar = ({ data }) => {
  const { calendar, error } = data

  if (error) return null

  if (!calendar.current || !calendar.next) return null

  return (
    <div className={classes.mainContainer}>
      <Month date={moment()} data={calendar.current} />
      <Month date={moment().add(1, 'month')} data={calendar.next} />
    </div>
  )
}

export default Calendar

command: "echo Hello World!"

refreshFrequency: false

render: (output) -> """
  <p>#{output}</p>
"""

style: """
  color: white
  font-family: Helvetica Neue
  font-weight: 300
  bottom: 50px
  right: 50px
"""

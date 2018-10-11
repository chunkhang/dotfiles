command: "cat quote.widget/quote.txt"

refreshFrequency: false

style: """
  color: #fff
  font-family: Helvetica Neue
  font-weight: 300
  font-size: 14px
  top: 25px
  left: 25px
  background: rgba(45, 45, 45, 0.85)
  border-radius: 5px
  padding: 15px 20px
"""

render: (_) -> """
  <div class="quote"></div>
  <div class="author"></div>
"""

update: (output, domEl) ->
  dom = $(domEl)
  strings = output.trim().split('\n')
  author = "- #{ strings.pop() }"
  quote = "\" #{ strings.join('\n') }\""

  dom.find(".quote").html quote
  dom.find(".author").html author

require! {
  React: 'react'
}

Dom = React.DOM
{div} = Dom

App = React.create-class do
  displayName: "App"

  render: ->
    div {},
      @props.active-route-handler! || "Loading..."

module.exports = App

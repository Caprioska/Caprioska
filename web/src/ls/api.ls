require! {
  React: 'react'
  './api/api.ls'
  './api/auth.ls'
}

Dom = React.DOM
{div} = Dom

App = React.create-class do
  displayName: "App"

  render: ->
    div {},
      @logged-in {}
      div {},
        @props.active-route-handler! || "Loading..."

module.exports = App

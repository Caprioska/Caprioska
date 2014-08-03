require! {
  React: 'react'
}
{div, h2} = React.DOM

Home = React.create-class do
  displayName: "Home"
  render: ->
    div null,
      div class-name: "main",
        div class-name: "ui grid",
          div class-name: "column",
            div class-name: "ui segment",
              h2 class-name:"ui center aligned header",
                "Welcome to the test version of Cuane Gradebook."

module.exports = Home

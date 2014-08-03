require! {
  Router: "react-router"

  App: "./app.ls"
}

{Route,Routes} = Router


module.exports =
  Routes {},
    Route {handler: App}

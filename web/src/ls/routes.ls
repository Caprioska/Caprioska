require! {
  Router: "react-router"

  App: "./app.ls"

  Home: "./home/home.ls"
}

{Route,Routes} = Router


module.exports =
  Routes {},
    Route handler: App,
      Route path: "/" name: "home" handler: Home

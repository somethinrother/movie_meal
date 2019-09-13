import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";
import { Provider } from "react-redux";
import { store } from "../store";
import MovieSearch from "./MovieSearch";

class App extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <BrowserRouter>
          <Switch>
            <Route exact path="/" render={() => <MovieSearch />} />
          </Switch>
        </BrowserRouter>
      </Provider>
    );
  }
}

export default App;

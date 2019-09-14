import React from "react";

import { BrowserRouter, Switch, Route } from "react-router-dom";
import { Provider } from "react-redux";
import { store } from "../store";

import MovieForm from "./MovieForm";

class App extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <BrowserRouter>
          <Switch>
            <Route exact path="/" component={MovieForm} />
          </Switch>
        </BrowserRouter>
      </Provider>
    );
  }
}

export default App;

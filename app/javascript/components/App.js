import React from "react";
import { Provider } from "react-redux";
import { createStore, applyMiddleware, compose } from "redux";
import reducer from "../reducers/index";
import thunk from "redux-thunk";
import MovieContainer from "./MovieContainer";
import { Router, Redirect } from "@reach/router";
import MovieDetailPage from "./MovieDetailPage";

class App extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <Router>
          <Redirect noThrow from="/" to="/movies" />
          <MovieContainer path="/movies" />
          <MovieDetailPage path="/movies/:movieId" />
        </Router>
      </Provider>
    );
  }
}
export default App;

const composeEnhancers =
  typeof window === "object" && window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__
    ? window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
        trace: true
      })
    : compose;

const enhancer = composeEnhancers(applyMiddleware(thunk));

const store = createStore(reducer, enhancer);

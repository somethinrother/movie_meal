import React from "react";
import MovieList from "./MovieList";
import { Provider } from "react-redux";
import { createStore } from "redux";
import reducer from "../reducers/index";

class App extends React.Component {
  render() {
    return (
      <Provider store={reduxStore}>
        <MovieList />
      </Provider>
    );
  }
}
export default App;

const reduxStore = createStore(reducer);

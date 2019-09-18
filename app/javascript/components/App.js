import React from "react";
import { createStore } from "redux";

class MovieList extends React.Component {
  render() {
    return (
      <div>
        <form>
          <label>Find A Movie</label>
          <div>
            <input type="" placeholder="Input Movie Title" />
            <button onClick={console.log("test")}>Search</button>
          </div>
        </form>
      </div>
    );
  }
}

class App extends React.Component {
  render() {
    return (
      <div>
        <MovieList />
      </div>
    );
  }
}
export default App;

const store = createStore(reducer);
export function reducer(state, action) {
  switch (action.type) {
    default:
      return state;
  }
}

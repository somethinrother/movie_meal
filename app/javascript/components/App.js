import React from "react";
import { createStore } from "redux";
import reducer from "../reducers/index";

const MovieList = ({ handleSubmit }) => {
  handleSubmit = e => {
    e.preventDefault();
    // dispatchEvent(getMovie(title));
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>Find A Movie</label>
        <div>
          <input type="text" placeholder="Input Movie Title" />
          <button onClick={console.log("test")}>Search</button>
        </div>
      </form>
    </div>
  );
};

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

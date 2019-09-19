import React from "react";
import { connect } from "react-redux";

const MovieList = ({}) => {
  const handleSubmit = e => {
    e.preventDefault();
    // dispatchEvent(getMovie(title));
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>Find A Movie</label>
        <div>
          <input type="text" placeholder="Input Movie Title" />
          <button type="submit">Search</button>
        </div>
      </form>
      <div>
        <h1>Movie List</h1>
        <button>Movie Ingredients</button>
        <button>Movie Recipes</button>
        <ul>
          <li>List Thing</li>
        </ul>
      </div>
    </div>
  );
};

const mapState = state => ({
  movies: state.movies
});

export default connect(mapState)(MovieList);

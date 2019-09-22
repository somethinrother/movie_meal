import React, { useState } from "react";
import { connect } from "react-redux";
import { getMovie, getMovies } from "../actions";
import MovieDisplay from "./MovieDisplay";

const MovieForm = ({ getMovie, getMovies, loading, error, selectedMovie }) => {
  const [movieTitle, setMovieTitle] = useState("");

  const handleSubmit = e => {
    e.preventDefault();
    getMovie(movieTitle);
  };

  const handleClick = e => {
    console.log("handleClick");
    getMovies();
  };

  if (error) {
    return <div>ERROR!! {error.message}</div>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }
  if (!selectedMovie) {
    getMovies();
  }
  if (selectedMovie.length > 0) {
    return (
      <div>
        <form onSubmit={handleSubmit}>
          <label>Find A Movie</label>
          <div>
            <input
              type="text"
              placeholder="Input Movie Title"
              value={movieTitle}
              onChange={e => setMovieTitle(e.target.value)}
            />
            <button type="submit">Search</button>
          </div>
        </form>
        <br />
        <h1>{selectedMovie[0].title}</h1>
        <span>Id: {selectedMovie[0].id}</span>
        <div>
          <button type="submit">Movie Ingredients</button>
          <button type="submit">Movie Recipes</button>
        </div>
      </div>

      // MAKE A FETCH METHOD TO GET THE APPROPRIATE DISPLAY INGREDIENTS // and RECIPES
    );
  }

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>Find A Movie</label>
        <div>
          <input
            type="text"
            placeholder="Input Movie Title"
            value={movieTitle}
            onChange={e => setMovieTitle(e.target.value)}
          />
          <button type="submit">Search</button>
        </div>
      </form>
      <button type="submit" onClick={handleClick}>
        Load All Movies
      </button>
    </div>
  );
};

const mapState = state => {
  return {
    selectedMovie: state.selectedMovie,
    movies: state.movies,
    loading: state.loading,
    error: state.error
  };
};

export default connect(
  mapState,
  { getMovies, getMovie }
)(MovieForm);

import React, { useState } from "react";
import { connect } from "react-redux";
import { getMovie, getMovies } from "../actions";
import MovieDisplay from "./MovieDisplay";

const MovieForm = ({ getMovie, getMovies, loading, error, selectedMovie }) => {
  const [movieTitle, setMovieTitle] = useState("");

  const handleSubmit = e => {
    e.preventDefault();
    console.log("handleSubmit");
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

  if (selectedMovie.length) {
    return <div>{selectedMovie[0].id}</div>;
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
      <button type="submit">Movie Ingredients</button>
      <button type="submit">Movie Recipes</button>
      <div>
        <MovieDisplay />
      </div>
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

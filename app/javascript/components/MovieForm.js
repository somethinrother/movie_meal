import React, { useState } from "react";
import { connect } from "react-redux";
import { getMovie, getMovies, getMovieIngredients } from "../actions";
import MovieList from "./MovieList";

const MovieForm = ({
  getMovieIngredients,
  getMovie,
  getMovies,
  loading,
  error,
  selectedMovie
}) => {
  const [movieTitle, setMovieTitle] = useState("");

  const handleSubmit = e => {
    e.preventDefault();
    getMovie(movieTitle);
  };

  const handleClick = e => {
    console.log("handleClick");
    getMovies();
  };

  const handleMovieIngredients = id => {
    console.log("handleMovieIngredients");
    getMovieIngredients(id);
    // call to database for movie.ingredients
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
          <label>Searched Movie: </label>
          <input
            type="text"
            placeholder="Input Movie Title"
            value={movieTitle}
            onChange={e => setMovieTitle(e.target.value)}
          />
          <button type="submit">Search Again</button>
        </form>
        <button
          type="submit"
          onClick={e => handleMovieIngredients(selectedMovie[0].id)}
        >
          Movie Ingredients
        </button>
        <button type="submit">Movie Recipes</button>
        <MovieList />
      </div>

      // MAKE A FETCH METHOD TO GET THE APPROPRIATE DISPLAY INGREDIENTS // and RECIPES
    );
  } else {
    return (
      <div>
        <form onSubmit={handleSubmit}>
          <div>
            <label>Find A Movie: </label>
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
        <MovieList />
      </div>
    );
  }
};

const mapState = (state, ownProps) => {
  return {
    selectedMovie: state.selectedMovie,
    movies: state.movies,
    loading: state.loading,
    error: state.error
  };
};

export default connect(
  mapState,
  { getMovies, getMovie, getMovieIngredients }
)(MovieForm);

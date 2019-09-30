import React, { useState } from "react";
import { connect } from "react-redux";
import { getMovies, getMovieByTitle } from "../actions";
import MovieList from "./MovieList";
import SelectedMovieDisplay from "./SelectedMovieDisplay";

const MovieForm = ({
  movies,
  getMovies,
  getMovieByTitle,
  loading,
  error,
  selectedMovie
}) => {
  const [movieTitle, setMovieTitle] = useState("");

  if (error) {
    return <div>ERROR!! {error.message}</div>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }

  if (movies && movies.length === 0) {
    getMovies();
  }

  const handleSubmit = e => {
    e.preventDefault();
    getMovieByTitle(movieTitle);
  };

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
      {selectedMovie && selectedMovie.length > 0 ? (
        <SelectedMovieDisplay selectedMovie={selectedMovie} />
      ) : (
        []
      )}
      <MovieList />
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
  { getMovies, getMovieByTitle }
)(MovieForm);

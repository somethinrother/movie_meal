import React, { useState, useEffect, useRef } from "react";
import { connect } from "react-redux";
import { getMovies, getMovieByTitle } from "../actions";
import _ from "lodash";
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
  const delayedQuery = useRef(_.debounce(e => getMovieByTitle(e), 500)).current;

  useEffect(() => {
    if (movies && movies.length === 0) {
      getMovies();
    }
  }, []);

  if (error) {
    return <div>ERROR!! {error.message}</div>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }

  const onChange = e => {
    setMovieTitle(e.target.value);
    delayedQuery(e.target.value);
  };

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
            onChange={onChange}
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

import React, { useState } from "react";
import { connect } from "react-redux";
import { getMovie, getMovies } from "../actions";
import MovieList from "./MovieList";

const MovieForm = ({
  movies,
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

  if (error) {
    return <div>ERROR!! {error.message}</div>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }
  if (movies && movies.length === 0) {
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
        <SelectedMovieDisplay selectedMovie={selectedMovie} />
        <MovieList />
      </div>
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
        <MovieList />
      </div>
    );
  }
};

export const SelectedMovieDisplay = ({ selectedMovie }) => {
  if (selectedMovie && selectedMovie.length > 0) {
    const movie = selectedMovie[0];
    return (
      <div>
        <h2>Viewing</h2>

        <h3>
          <i>Movie Title: </i>
          {selectedMovie[0].title}
          <br />
          <i>Id:</i> {selectedMovie[0].id}
        </h3>
        <span>
          {selectedMovie && movie["script"] ? (
            <div>movie.script</div>
          ) : (
            "There is no Movie Script Scraped Yet"
          )}
        </span>
      </div>
    );
  } else {
    return null;
  }
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

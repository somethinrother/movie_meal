import React from "react";
import { connect } from "react-redux";
import { getMovies } from "../actions";
import MovieList from "./MovieList";

const MovieForm = ({ movies, getMovies, loading, error }) => {
  if (error) {
    return <div>ERROR!! {error.message}</div>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }
  if (movies && movies.length === 0) {
    getMovies();
  }

  return (
    <div>
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
  { getMovies }
)(MovieForm);

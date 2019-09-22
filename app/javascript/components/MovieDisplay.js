import React from "react";
import { connect } from "react-redux";
import { getMovies } from "../actions";
import { getMovieByTitle } from "../selectors";

const MovieDisplay = ({ getMovies, loading, error, selectedMovie }) => {
  if (error) {
    return <h2>Error: {error.message}</h2>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }

  return (
    <div>
      <ul>
        {selectedMovie ? (
          <li key={selectedMovie.id}>
            <div className="title">
              {selectedMovie.id}. {selectedMovie.title}
            </div>
          </li>
        ) : (
          "No movies returned."
        )}
      </ul>
    </div>
  );
};

function mapStateToProps(state) {
  return {
    selectedMovie: state.selectedMovie,
    movies: state.movies,
    error: state.error,
    loading: state.loading
  };
}

export default connect(
  mapStateToProps,
  { getMovies }
)(MovieDisplay);

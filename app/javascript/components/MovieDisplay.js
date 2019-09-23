import React from "react";
import { connect } from "react-redux";

const MovieDisplay = ({ selectedMovie, movies, loading, error }) => {
  if (error) {
    return <h2>Error: {error.message}</h2>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }

  if (selectedMovie.length > 0) {
    return (
      <div>
        <h3>
          <i>Movie Title: </i>
          {selectedMovie[0].title}
          <br />
          <i>Id:</i> {selectedMovie[0].id}
        </h3>
        <div className="title">
          <h3>List of Movies Found</h3>
          {movies &&
            movies.map(movie => (
              <li key={movie.id}>
                <i>Id: </i>
                {movie.id}, <i>Title:</i> {movie.title}
              </li>
            ))}
        </div>
      </div>
    );
  }

  if (movies && selectedMovie.length === 0) {
    return (
      <div className="title">
        {movies &&
          movies.map(movie => (
            <li key={movie.id}>
              <i>Id: </i>
              {movie.id}, <i>Title:</i> {movie.title}
            </li>
          ))}
      </div>
    );
  } else {
    return null;
  }
};

const mapStateToProps = state => ({
  selectedMovie: state.selectedMovie,
  movies: state.movies,
  error: state.error,
  loading: state.loading
});

export default connect(mapStateToProps)(MovieDisplay);

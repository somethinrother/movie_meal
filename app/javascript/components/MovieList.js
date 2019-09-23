import React from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";

const MovieList = ({ selectedMovie, movies, loading, error }) => {
  if (error) {
    return <h2>Error: {error.message}</h2>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }

  if (movies) {
    return (
      <div className="title">
        {movies.length > 0 && <h3>List of Movies Found</h3>}
        {movies &&
          movies.map(movie => (
            <li key={movie.id}>
              <Link to={`/movies/${movie.id}`}>
                <i>Id: </i>
                {movie.id}, <i>Title:</i> {movie.title}
              </Link>
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

export default connect(mapStateToProps)(MovieList);

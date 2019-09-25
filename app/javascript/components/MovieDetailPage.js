import React from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";

const MovieDetailPage = ({ movieId, movie, loading }) => {
  if (loading) {
    return <div>Loading Movie Detail Page, id: {movieId}</div>;
  }

  return (
    <div>
      <h2>Viewing</h2>
      Movie Id: <i>{movieId}</i>
      <br />
      <i>{movie ? "Title:  " + movie["title"] : []}</i>
      <br />
      {movie && movie["script"] ? (
        <div>movie.script</div>
      ) : (
        "There is no Movie Script Scraped Yet"
      )}
      <br />
      <button>
        <Link to={`/movies`}>Go Back</Link>
      </button>
      <button>
        <Link to={`/movies/${movieId}/ingredients`}>Movie Ingredients</Link>
      </button>
    </div>
  );
};

const mapState = (state, ownProps) => {
  return {
    loading: state.loading,
    movies: state.movies,
    movie: state.movies.find(
      movie => movie.id === parseInt(ownProps.movieId, 10)
    )
  };
};
export default connect(mapState)(MovieDetailPage);
import React from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";

const MovieDetailPage = ({ getMovieById, movieId, movie }) => {
  if (!movie) {
    getMovieById(movieId);
  }

  return (
    <div>
      <button>
        <Link to={`/movies`}>Go Back</Link>
      </button>
      <h2>Viewing</h2>
      Movie Id: <i>{movieId}</i>
      <br />
      <i>{movie ? "Title:  " + movie["title"] : []}</i>
      <br />
      {movie && movie["script"] ? (
        <div>{movie.script}</div>
      ) : (
        "There is no Movie Script Scraped Yet"
      )}
    </div>
  );
};

const mapState = state => {
  return {
    movie: state.selectedMovie.movie
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

import React from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
// import { getMovieById } from "../selectors";

const MovieDetailPage = ({ movieId, selectedMovie, loading }) => {
  if (loading) {
    return <div>Loading Movie Detail Page, id: {movieId}</div>;
  }

  if (!selectedMovie) {
    return <div>No Movie Selected</div>;
  }

  return (
    <div>
      <button>
        <Link to={`/movies`}>Go Back</Link>
      </button>
      <br />
      Viewing Movie Id: <i>{movieId}</i>
      <br />
      <i>{selectedMovie ? selectedMovie["title"] : []}</i>
      <br />
      {selectedMovie && selectedMovie["script"] ? (
        <div>selectedMovie.script</div>
      ) : (
        "There is no Movie Script Scraped Yet"
      )}
    </div>
  );
};

const mapState = (state, ownProps) => {
  return {
    loading: state.loading,
    movies: state.movies,
    selectedMovie: state.movies.find(
      movie => movie.id === parseInt(ownProps.movieId, 10)
    )
  };
};
export default connect(mapState)(MovieDetailPage);

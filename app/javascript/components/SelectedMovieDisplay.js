import React from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import "./MovieContainer/style.scss";

const SelectedMovieDisplay = ({ selectedMovie }) => {
  return (
    <div
      className={
        selectedMovie && selectedMovie.length > 0 ? "selected-movie" : null
      }
    >
      <ul>
        {selectedMovie && selectedMovie.length > 0 ? (
          <span className="found">Found...</span>
        ) : (
          []
        )}
        {selectedMovie && selectedMovie.length > 0
          ? selectedMovie.map(movie => (
              <li key={movie.id}>
                <Link to={`/movies/${movie.id}`}>{movie.title}</Link>
              </li>
            ))
          : []}
      </ul>
    </div>
  );
};

const mapState = state => {
  return {
    selectedMovie: state.selectedMovie
  };
};

export default connect(mapState)(SelectedMovieDisplay);

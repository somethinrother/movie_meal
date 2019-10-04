import React from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";

const SelectedMovieDisplay = ({ selectedMovie }) => {
  return (
    <div>
      <ul>
        {selectedMovie && selectedMovie.length > 0
          ? selectedMovie.map(movie => (
              <li key={movie.id}>
                <Link to={`/movies/${movie.id}`}>
                  <i>Found: </i>
                  {movie.title}
                </Link>
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

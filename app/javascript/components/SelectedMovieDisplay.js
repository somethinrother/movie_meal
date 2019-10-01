import React from "react";
import { Link } from "@reach/router";

const SelectedMovieDisplay = ({ selectedMovie }) => {
  return (
    <div>
      <ul>
        {selectedMovie
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

export default SelectedMovieDisplay;

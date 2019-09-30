import React from "react";
import { Link } from "@reach/router";

const SelectedMovieDisplay = ({ selectedMovie }) => {
  return (
    <div>
      Found:
      <Link to={`/movies/${selectedMovie[0].id}`}>
        {selectedMovie ? selectedMovie[0].title : []}
      </Link>
    </div>
  );
};

export default SelectedMovieDisplay;

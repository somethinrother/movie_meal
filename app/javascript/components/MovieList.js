import React from "react";
import { Link } from "@reach/router";

const MovieList = ({ movies, loading, error }) => {
  if (error) {
    return <h2>Error: {error.message}</h2>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }

  return (
    <ul className="title">
      {movies && movies.length > 0
        ? movies.map(movie => (
            <li key={movie.id}>
              <Link to={`/movies/${movie.id}`}>{movie.title}</Link>
            </li>
          ))
        : []}
    </ul>
  );
};

export default MovieList;

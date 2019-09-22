import React, { useState } from "react";
import { connect } from "react-redux";
import { getMovies } from "../actions";

const MovieList = ({ dispatch, loading, error, movies }) => {
  const [movieName, setMovieName] = useState("");

  const handleSubmit = e => {
    e.preventDefault();
    dispatch(getMovies());
  };

  const handleAllMoviesButton = e => {
    return dispatch(getMovies());
  };

  if (error) {
    return <div>ERROR!! {error.message}</div>;
  }

  if (loading) {
    return <h1>LOADING!</h1>;
  }

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>Find A Movie</label>
        <div>
          <input
            type="text"
            placeholder="Input Movie Title"
            value={movieName}
            onChange={e => setMovieName(e.target.value)}
          />
          <button type="submit">Search</button>
        </div>
      </form>
      <button type="submit" onClick={handleAllMoviesButton}>
        All Movies
      </button>
      <button type="submit">Movie Ingredients</button>
      <button type="submit">Movie Recipes</button>
      <div>
        <ul>
          {movies
            ? movies.map(movie => (
                <li key={movie.id}>
                  <div className="title">
                    {movie.id}. {movie.title}
                  </div>
                </li>
              ))
            : []}
        </ul>
      </div>
    </div>
  );
};

const mapState = state => ({
  movies: state.movies,
  loading: state.loading,
  error: state.error
});

export default connect(mapState)(MovieList);

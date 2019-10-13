import React, { useState, useEffect, useRef } from "react";
import { connect } from "react-redux";
import _ from "lodash";
import { getMovies, getMovieByTitle } from "../actions";
import MovieList from "./MovieList";
import Pagination from "./Pagination";
import SelectedMovieDisplay from "./SelectedMovieDisplay";
import "./MovieContainer.css";

const MovieContainer = ({
  getMovieByTitle,
  movies,
  getMovies,
  loading,
  error
}) => {
  // Search Form
  const [movieTitle, setMovieTitle] = useState("");
  const inputRef = useRef();
  const delayedQuery = useRef(_.debounce(e => getMovieByTitle(e), 500)).current;
  // Pagination
  const [currentPage, setCurrentPage] = useState(1);
  const [moviesPerPage] = useState(20);

  const indexOfLastMovie = currentPage * moviesPerPage;
  const indexOfFirstMovie = indexOfLastMovie - moviesPerPage;
  const currentMovies = movies.slice(indexOfFirstMovie, indexOfLastMovie);

  const paginate = pageNumber => setCurrentPage(pageNumber);

  useEffect(() => {
    inputRef.current.focus();
    if (movies && movies.length === 0) {
      getMovies();
    }
  }, []);

  if (error) {
    return <div>ERROR!! {error.message}</div>;
  }

  if (loading) {
    return <h1>Loading...</h1>;
  }

  // Form Code
  const onChange = e => {
    setMovieTitle(e.target.value);
    delayedQuery(e.target.value);
  };

  const handleSubmit = e => {
    e.preventDefault();
    getMovieByTitle(movieTitle);
  };

  return (
    <div className="movie-container">
      <form onSubmit={handleSubmit}>
        <label>Find A Movie: </label>
        <input
          ref={inputRef}
          type="text"
          placeholder="Input Movie Title"
          value={movieTitle}
          onChange={onChange}
        />
        <button type="submit">Search</button>
      </form>
      <SelectedMovieDisplay />
      <MovieList movies={currentMovies} loading={loading} error={error} />
      <Pagination
        moviesPerPage={moviesPerPage}
        totalPosts={movies.length}
        paginate={paginate}
      />
    </div>
  );
};

const mapState = state => {
  return {
    selectedMovie: state.selectedMovie,
    movies: state.movies,
    loading: state.loading,
    error: state.error
  };
};

export default connect(
  mapState,
  { getMovies, getMovieByTitle }
)(MovieContainer);

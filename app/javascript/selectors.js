import { createSelector } from "reselect";

const getMovies = state => state.movies;
const parseMovieTitle = (state, props) => props.movieTitle;

export const getMovieById = createSelector(
  getMovies,
  parseMovieTitle,
  (movies, movieTitle) => movies.find(movie => movie.title === movieTitle)
);

import { createSelector } from "reselect";

const getMoviesState = state => {
  state.movies;
};
const parseMovieId = (state, ownProps) => parseInt(ownProps.movieId, 10);

export const getMovieById = createSelector(
  getMoviesState,
  parseMovieId,
  (state, ownProps) =>
    state.movies.find(movie => movie.id === parseInt(ownProps.movieId, 10))
);

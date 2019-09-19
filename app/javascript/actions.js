export function getMovies() {
  return dispatch => {
    dispatch(
      getMoviesRequest()
        .then(fetch(`v1/movies`))
        .then(res => res.json())
        .then(json => dispatch(getMoviesSuccess(json, title)))
        .catch(error => console.log(error))
    );
  };
}

// export function getMovie(title) {
//   return dispatch => {
//     dispatch(
//       getMovieRequest()
//         .then(fetch(`v1/movies`))
//         .then(res => res.json())
//         .then(json => dispatch(getMovieSuccess(json, title)))
//         .catch(error => console.log(error))
//     );
//   };
// }

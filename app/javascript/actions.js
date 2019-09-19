export const GET_MOVIES_REQUEST = "GET_MOVIES_REQUEST";
export const GET_MOVIES_SUCCESS = "GET_MOVIES_SUCCESS";
export const GET_MOVIES_ERROR = "GET_MOVIES_ERROR";

export function getMoviesRequest() {
  return {
    type: GET_MOVIES_REQUEST
  };
}

export function getMoviesSuccess(json) {
  return {
    type: GET_MOVIES_SUCCESS,
    json
  };
}

export function getMoviesError(error) {
  return {
    type: GET_MOVIES_ERROR,
    error
  };
}

export function getMovies() {
  return dispatch => {
    dispatch(
      getMoviesRequest()
        .then(fetch(`v1/movies`))
        .then(res => res.json())
        .then(json => dispatch(getMoviesSuccess(json, title)))
        .catch(error => dispatch(getMoviesError(error)))
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

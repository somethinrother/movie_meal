export const GET_MOVIES_REQUEST = "GET_MOVIES_REQUEST";
export const GET_MOVIES_SUCCESS = "GET_MOVIES_SUCCESS";
export const GET_MOVIES_ERROR = "GET_MOVIES_ERROR";
export const GET_MOVIE_REQUEST = "GET_MOVIE_REQUEST";

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
    dispatch({
      type: GET_MOVIES_REQUEST
    });
    fetch(`v1/movies`)
      .then(res => res.json())
      .then(json =>
        dispatch({
          type: GET_MOVIES_SUCCESS,
          json
        })
      )
      .catch(error =>
        dispatch({
          type: GET_MOVIES_ERROR,
          error
        })
      );
  };
}

export function getMovie(title) {
  // get title, get all movies array
}

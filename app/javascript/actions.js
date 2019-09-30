export const GET_MOVIES_REQUEST = "GET_MOVIES_REQUEST";
export const GET_MOVIES_SUCCESS = "GET_MOVIES_SUCCESS";
export const GET_MOVIES_ERROR = "GET_MOVIES_ERROR";
export const GET_MOVIE_REQUEST = "GET_MOVIE_REQUEST";
export const GET_MOVIE_SUCCESS = "GET_MOVIE_SUCCESS";
export const GET_MOVIE_ERROR = "GET_MOVIE_ERROR";
export const GET_MOVIE_BY_ID_REQUEST = "GET_MOVIE_BY_ID_REQUEST";
export const GET_MOVIE_BY_ID_SUCCESS = "GET_MOVIE_BY_ID_SUCCESS";

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

export function getMovieByIdRequest(id) {
  return {
    type: GET_MOVIE_BY_ID_REQUEST,
    id
  };
}

export function getMovieByIdSuccess(json) {
  return {
    type: GET_MOVIE_BY_ID_SUCCESS,
    json
  };
}

export function getMovies() {
  console.log("getMovies()");
  return dispatch => {
    dispatch({
      type: GET_MOVIES_REQUEST
    });
    fetch(`/v1/movies`)
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

export const getMovieById = id => {
  return dispatch => {
    dispatch(getMovieByIdRequest(id));
    const json = fetch(`/v1/movies/${id}`)
      .then(res => res.json())
      .then(json => dispatch(getMovieByIdSuccess(json)));
  };
};

export const GET_MOVIES_REQUEST = "GET_MOVIES_REQUEST";
export const GET_MOVIES_SUCCESS = "GET_MOVIES_SUCCESS";
export const GET_MOVIES_ERROR = "GET_MOVIES_ERROR";
export const GET_MOVIE_REQUEST = "GET_MOVIE_REQUEST";
export const GET_MOVIE_SUCCESS = "GET_MOVIE_SUCCESS";
export const GET_MOVIE_ERROR = "GET_MOVIE_ERROR";
export const GET_MOVIE_INGREDIENTS = "GET_MOVIE_INGREDIENTS";
export const GET_MOVIE_INGREDIENTS_SUCCESS = "GET_MOVIE_INGREDIENTS_SUCCESS";

export function getMovieRequest(title) {
  return {
    type: GET_MOVIE_REQUEST,
    title
  };
}

export function getMovieSuccess(title) {
  return {
    type: GET_MOVIE_SUCCESS,
    title
  };
}

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

export function getMovieIngredientsRequest(id) {
  return {
    type: GET_MOVIE_INGREDIENTS,
    id
  };
}

export function getMovieIngredientsSuccess(json) {
  return {
    type: GET_MOVIE_INGREDIENTS_SUCCESS,
    json
  };
}

export function getMovies() {
  console.log("getMovies()");
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
  return dispatch => {
    dispatch(getMovieRequest(title));
    dispatch(getMovieSuccess(title));
  };
}

export function getMovieIngredients(id) {
  return dispatch => {
    dispatch(getMovieIngredientsRequest(id));
    fetch(`v1/movies/${id}/ingredients`)
      .catch(error => console.log(error))
      .then(res => res.json())
      .then(json => dispatch(getMovieIngredientsSuccess(json)))
      .catch(error => console.log(error));
  };
}

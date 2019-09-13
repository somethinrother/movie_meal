const GET_INGREDIENTS_REQUEST = "GET_INGREDIENTS_REQUEST";
const GET_INGREDIENTS_SUCCESS = "GET_INGREDIENTS_SUCCESS";
const GET_RECIPES_REQUEST = "GET_RECIPES_REQUEST";
const GET_RECIPES_SUCCESS = "GET_RECIPES_SUCCESS";

export function getIngredientsRequest() {
  return {
    type: GET_INGREDIENTS_REQUEST
  };
}

export function getIngredientsSuccess(json) {
  return {
    type: GET_INGREDIENTS_SUCCESS,
    json
  };
}

export function getRecipesRequest() {
  return {
    type: GET_RECIPES_REQUEST
  };
}

export function getRecipesSuccess(json) {
  return {
    type: GET_RECIPES_SUCCESS,
    json
  };
}

export function getMovieRequest(title) {
  return {
    type: GET_MOVIE_REQUEST,
    title
  };
}

export function getMovieSuccess(json) {
  return {
    type: GET_MOVIE_SUCCESS,
    json
  };
}

export function getIngredients() {
  return dispatch => {
    dispatch(getIngredientsRequest());
    return fetch(`v1/ingredients`)
      .then(response => response.json())
      .then(json => dispatch(getIngredientsSuccess(json)))
      .catch(error => console.log(error));
  };
}

export function getRecipes() {
  return dispatch => {
    dispatch(getRecipesRequest());
    return fetch(`v1/recipes`)
      .then(response => response.json())
      .then(json => dispatch(getRecipesSuccess(json)))
      .catch(error => console.log(error));
  };
}

export function getMovie(title) {
  return dispatch => {
    dispatch(getMovieRequest(title));
    return fetch(`v1/movies`)
      .then(response => response.json())
      .then(json => dispatch(getMovieSuccess(json)))
      .catch(error => console.log(error));
  };
}

const GET_INGREDIENTS_REQUEST = 'GET_INGREDIENTS_REQUEST';
const GET_INGREDIENTS_SUCCESS = 'GET_INGREDIENTS_SUCCESS';
const HIDE_INGREDIENTS = 'HIDE_INGREDIENTS';

const GET_INGREDIENT_REQUEST = 'GET_INGREDIENT_REQUEST';
const GET_INGREDIENT_SUCCESS = 'GET_INGREDIENT_SUCCESS';

export function getIngredientRequest(id) {
  return {
    type: GET_INGREDIENT_REQUEST,
    id
  }
}

export function getIngredientSuccess(json) {
  return {
    type: GET_INGREDIENT_SUCCESS,
    json
  }
}

export function getIngredientsRequest() {
	return {
			type: GET_INGREDIENTS_REQUEST
		}
}

export function getIngredientsSuccess(json) {
  return {
    type: GET_INGREDIENTS_SUCCESS,
    json
  }
}

export function hideIngredients() {
  return dispatch => {
    dispatch({ type: HIDE_INGREDIENTS });
  }
}

export function getIngredients() {
  return dispatch => {
    dispatch(getIngredientsRequest());
    return fetch(`v1/ingredients`)
      .then(response => response.json())
      .then(json => dispatch(getIngredientsSuccess(json)))
      .catch(error => console.log(error));
  }
}

export function getIngredient(id) {
  return dispatch => {
		console.log("trying to get id to show up =>", id)
    dispatch(getIngredientRequest(id));
    return fetch(`v1/ingredients`)
      .catch(error => console.log(error))
      .then(response => response.json())
      .then(json => dispatch(getIngredientSuccess(json)))
      .catch(error => console.log(error));
  }
}

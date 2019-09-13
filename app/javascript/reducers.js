import { combineReducers } from "redux";

const initialState = {
  ingredients: [],
  recipes: []
};

function recipeReducer(state = initialState, action) {
  console.log(action.type);
  switch (action.type) {
    case "GET_RECIPES_SUCCESS":
      console.log("action.json.recipes:", action.json.recipes);
      return { ...state, recipes: action.json.recipes };
    case "GET_RECIPES_REQUEST":
      console.log("Recipes request received");
      return state;
    default:
      return state;
  }
}

// NOW YOU HAVE TO FILTER THE INGREDIENTS IN REDUCER METHOD SO ITS ONLY FROM THAT ONE MOVIE

function ingredientReducer(state = initialState, action) {
  console.log(action.type);
  switch (action.type) {
    case "GET_INGREDIENTS_SUCCESS":
      console.log("action.json.ingredients:", action.json.ingredients);
      return { ...state, ingredients: action.json.ingredients };
    case "GET_INGREDIENTS_REQUEST":
      console.log("Ingredients request received");
      return state;
    default:
      return state;
  }
}

rootReducer = combineReducers(ingredientReducer, recipeReducer);
export default rootReducer;

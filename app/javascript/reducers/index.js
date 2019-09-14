import { combineReducers } from "redux";
import ingredientsReducer from "./ingredients";
import recipesReducer from "./recipes";
import movieReducer from "./movie";

const rootReducer = combineReducers({
  ingredientsReducer,
  recipesReducer,
  movieReducer
});

export default rootReducer;

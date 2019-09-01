import { createStore, applyMiddleware, compose } from "redux";
import thunk from 'redux-thunk'
import { composeWithDevTools } from 'redux-devtools-extension';

const initialState = {
  ingredients: []
};

function rootInducer(state = initialState, action) {
  console.log(action.type);
  switch (action.type) {
    case "GET_INGREDIENTS_SUCCESS":
      return { ...state, ingredients: action.json.ingredients }
    case "GET_INGREDIENTS_REQUEST":
      console.log('Ingredients request received')
      return
    case "HIDE_INGREDIENTS":
      console.log('Ingredients are being hidden')
      return { ...state, ingredients: [] }
    case "GET_INGREDIENT_REQUEST":
      console.log('One Ingredient request received', "id:", action.id)
      return
    case "GET_INGREDIENT_SUCCESS":
      return { ...state, ingredients: action.json.ingredients }
    default:
      return state
  }
}

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

export default function configureStore() {
  const store = createStore(
    rootInducer,
    composeEnhancers(applyMiddleware(thunk))
  );
  return store;
}

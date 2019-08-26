import { createStore, applyMiddleware, compose } from "redux";
import thunk from 'redux-thunk'
import { composeWithDevTools } from 'redux-devtools-extension';

const initialState = {
  ingredients: []
};

function rootInducer(state, action) {
  console.log(action.type);
  switch (action.type) {
    case "GET_INGREDIENTS_SUCCESS":
      return { ingredients: action.json.ingredients }
    case "GET_INGREDIENTS_REQUEST":
      console.log('Ingredients request received')
      return
    case "HIDE_INGREDIENTS":
      console.log('Ingredients are being hidden')
      return { ingredients: [] }
  }
  return state;
}

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

export default function configureStore() {
  const store = createStore(
    rootInducer,
    initialState,
    composeEnhancers(applyMiddleware(thunk))
  );
  return store;
}

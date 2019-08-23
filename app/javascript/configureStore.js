import { createStore, applyMiddleware, compose } from "redux";
import thunk from 'redux-thunk'
import { composeWithDevTools } from 'redux-devtools-extension';

const initialState = {
  ingredients: []
};

function rootInducer(state, action) {
  switch (action.type) {
    case "GET_INGREDIENTS_SUCCESS":
      return { ingredients: action.json.ingredients }
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

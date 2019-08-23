import { createStore, applyMiddleware } from "redux";
import thunk from 'redux-thunk'

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

export default function configureStore() {
  const store = createStore(
    rootInducer,
    initialState,
    applyMiddleware(thunk)
  );
  return store;
}

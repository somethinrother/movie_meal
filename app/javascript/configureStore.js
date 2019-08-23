import { createStore } from "redux";

const initialState = {
  ingredients: []
};

function rootInducer(state, action) {
  console.log(action.type);
  switch (action.type) {
    default:
      return state
  }
}

export default function configureStore() {
  const store = createStore(rootInducer, initialState);
  return store;
}

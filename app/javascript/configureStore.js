import { createStore } from "redux";

const initialState = {
  ingredients: [
    {
      id: 1,
      name: 'apple'
    },
    {
      id: 2,
      name: 'cheese'
    },
    {
      id: 3,
      name: 'wine'
    }
  ]
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

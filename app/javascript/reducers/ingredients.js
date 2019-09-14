const initialState = {
  ingredients: []
};

function ingredientsReducer(state = initialState, action) {
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

export default ingredientsReducer;

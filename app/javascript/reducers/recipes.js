const initialState = {
  recipes: []
};

function recipesReducer(state = initialState, action) {
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

export default recipesReducer;

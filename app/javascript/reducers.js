const initialState = {
  ingredients: []
};

function rootReducer(state = initialState, action) {
  console.log(action.type);
  switch (action.type) {
    case "GET_INGREDIENTS_SUCCESS":
      console.log("action.json.ingredients:", action.json.ingredients);
      return { ...state, ingredients: action.json.ingredients };
    case "GET_INGREDIENTS_REQUEST":
      console.log("Ingredients request received");
      return state;
    case "HIDE_INGREDIENTS":
      console.log("Ingredients are being hidden");
      return { ...state, ingredients: [] };
    case "GET_INGREDIENT_REQUEST":
      console.log("One Ingredient request received:", "id:", action.id);
      return state;
    case "GET_INGREDIENT_SUCCESS":
      console.log("GET_INGREDIENT_SUCCESS");
      const ingredients = action.json.ingredients;
      const id = action.id;

      return {
        ...state,
        ingredients: ingredients.filter(
          ingredient => ingredient.id.toString() === id
        )
      };
    default:
      return state;
  }
}

export default rootReducer;

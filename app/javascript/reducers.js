const initialState = {
  ingredients: []
};

function rootReducer(state = initialState, action) {
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
      console.log('One Ingredient request received:', "id:", action.id)
      return
    case "GET_INGREDIENT_SUCCESS":
    console.log('GET_INGREDIENT_SUCCESS')
      return {
				...state,
				ingredients: action.json.ingredients.filter(i => i.id)
			}
    default:
      return state
  }
}

export default rootReducer;

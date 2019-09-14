const initialState = {
  movie: []
};

function movieReducer(state = initialState, action) {
  switch (action.type) {
    case "GET_MOVIE_SUCCESS":
      console.log("action.json.recipes:", action.json.recipes);
      return { ...state, recipes: action.json.recipes };
    case "GET_MOVIE_REQUEST":
      console.log("Movie request received");
      return state;
    default:
      return state;
  }
}

export default movieReducer;

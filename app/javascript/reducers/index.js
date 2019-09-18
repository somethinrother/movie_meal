import produce from "immer";
import { GET_MOVIE_REQUEST, GET_MOVIE_SUCCESS } from "./actions";

export function reducer(state,action) {
  default:
    return
}

const reducer = produce((draft, action) => {
  switch (action.type) {
    case GET_MOVIE_SUCCESS:
      console.log("GET_MOVIE_SUCCESS", action);
      draft.moviesById = action.json.movies;
      draft.loading = false;
      return;
    case GET_MOVIE_REQUEST:
      console.log("GET_MOVIE_REQUEST", action);
      draft.title = action.title;
      draft.loading = true;
    default:
      return;
  }
});

export default reducer;

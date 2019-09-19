import produce from "immer";
import {
  GET_MOVIES_REQUEST,
  GET_MOVIES_SUCCESS,
  GET_MOVIES_ERROR
} from "../actions";

const initialState = {
  movies: [],
  loading: false,
  error: null
};
const reducer = produce((draft, action) => {
  switch (action.type) {
    case GET_MOVIES_REQUEST:
      console.log("GET_MOVIES_REQUEST");
      draft.loading = true;
      return;
    case GET_MOVIES_SUCCESS:
      console.log("GET_MOVIES_SUCCESS");
      draft.movies = action.json.movies;
      draft.loading = false;
      return;
    case GET_MOVIES_ERROR:
      console.log("GET_MOVIES_ERROR");
      draft.error = action.error;
      return;
  }
}, initialState);

export default reducer;

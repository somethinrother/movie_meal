import produce from "immer";
import {
  GET_MOVIES_REQUEST,
  GET_MOVIES_SUCCESS,
  GET_MOVIES_ERROR,
  GET_MOVIE_REQUEST,
  GET_MOVIE_SUCCESS,
  GET_MOVIE_BY_ID_REQUEST,
  GET_MOVIE_BY_ID_SUCCESS
} from "../actions";

const initialState = {
  selectedMovie: [],
  movies: [],
  loading: false,
  error: null
};
const reducer = produce((draft, action) => {
  switch (action.type) {
    case GET_MOVIES_REQUEST:
      console.log("GET_MOVIES_REQUEST");
      draft.loading = true;
      draft.error = action.error;
      return;
    case GET_MOVIES_SUCCESS:
      console.log("GET_MOVIES_SUCCESS");
      draft.movies = action.json.movies;
      draft.loading = false;
      return;
    case GET_MOVIES_ERROR:
      console.log("GET_MOVIES_ERROR");
      draft.loading = false;
      draft.error = action.error;
      return;
    case GET_MOVIE_REQUEST:
      console.log("GET_MOVIE_REQUEST");
      draft.loading = true;
      draft.error = action.error;
      return;
    case GET_MOVIE_SUCCESS:
      console.log("GET_MOVIE_SUCCESS");
      draft.movies = action.json.movies;
      draft.loading = false;
      return;
    case GET_MOVIE_BY_ID_REQUEST:
      console.log("GET_MOVIE_BY_ID_REQUEST");
      draft.loading = true;
      return;
    case GET_MOVIE_BY_ID_SUCCESS:
      console.log("GET_MOVIE_SUCCESS");
      draft.loading = false;
      return;
  }
}, initialState);

export default reducer;

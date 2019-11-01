import produce from "immer";
import {
  GET_MOVIES_REQUEST,
  GET_MOVIES_SUCCESS,
  GET_MOVIES_ERROR,
  GET_MOVIE_BY_ID_REQUEST,
  GET_MOVIE_BY_ID_SUCCESS,
  GET_MOVIE_BY_TITLE_REQUEST,
  GET_MOVIE_BY_TITLE_SUCCESS
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
      draft.loading = true;
      draft.error = action.error;
      return;
    case GET_MOVIES_SUCCESS:
      draft.movies = action.json.movies.filter(movie => movie.script);
      draft.loading = false;
      return;
    case GET_MOVIES_ERROR:
      draft.loading = false;
      draft.error = action.error;
      return;
    case GET_MOVIE_BY_ID_REQUEST:
      draft.loading = true;
      return;
    case GET_MOVIE_BY_ID_SUCCESS:
      draft.loading = false;
      draft.selectedMovie = action.json;
      return;
    case GET_MOVIE_BY_TITLE_REQUEST:
      draft.loading = true;
      return;
    case GET_MOVIE_BY_TITLE_SUCCESS:
      draft.loading = false;
      if (action.title === " " || action.title.length === 0) {
        draft.selectedMovie = null;
        return;
      }
      const search_movie_title = action.title.replace(/[^0-9A-Za-z]/g, "");

      draft.selectedMovie = draft.movies.filter(movie =>
        movie.title
          .replace(/[^0-9A-Za-z]/g, "")
          .toLowerCase()
          .includes(search_movie_title.toLowerCase())
      );
      return;
  }
}, initialState);

export default reducer;

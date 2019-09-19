import produce from "immer";

export const GET_MOVIES_REQUEST = "GET_MOVIES_REQUEST";
export const GET_MOVIE_SUCCESS = "GET_MOVIE_SUCCESS";

export function getMoviesRequest() {
  return {
    type: GET_MOVIES_REQUEST
  };
}

export function getMoviesSuccess(json) {
  return {
    type: GET_MOVIE_SUCCESS,
    json
  };
}

const initialState = {
  movies: [],
  loading: false
};
const reducer = produce((draft, action) => {
  switch (action.type) {
    case "GET_MOVIES_REQUEST":
      console.log("GET_MOVIES_REQUEST");
      draft.loading = true;
      return;
    case "GET_MOVIES_SUCCESS":
      console.log("GET_MOVIES_SUCCESS");
      draft.movies = action.json.movies;
      draft.loading = false;
      return;
  }
}, initialState);
export default reducer;

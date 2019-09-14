const initialState = {
  movie: []
};

function movieReducer(state = initialState, action) {
  switch (action.type) {
    case "GET_MOVIE_SUCCESS":
      console.log("action.json.movies:", action);
      return {
        ...state,
        movie: action.json.movies.map((movie, title) => {
          movie.title === title;
        })
      };
    case "GET_MOVIE_REQUEST":
      console.log("GET_MOVIE_REQUEST", action);
      return {
        ...state,
        title: action.title
      };

    default:
      return state;
  }
}

export default movieReducer;

import React, { useEffect } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";

const MovieDetailPage = ({
  getMovieById,
  movieId,
  movie,
  ingredients,
  recipe_map
}) => {
  useEffect(() => {
    getMovieById(movieId);
  }, []);

  return (
    <div>
      <button>
        <Link to={`/movies`}>Go Back</Link>
      </button>
      <h1>{movie ? "Title:  " + movie["title"] : []}</h1>
      <h3>Ingredients Mentioned:</h3>
      <ul>
        {ingredients
          ? ingredients.map(ingredient => (
              <li key={Math.random()}>{ingredient.name}</li>
            ))
          : []}
      </ul>
      <h3>Recipes Mentioned:</h3>
      <ul>
        {recipe_map
          ? recipe_map.map(recipe => (
              <li key={Math.random()}>
                <i>{recipe[1].name}</i>, Mentions:{" "}
                {recipe[0].ingredient_mentions}, Total %{" "}
                {recipe[0].mentions_percentage}
              </li>
            ))
          : []}
      </ul>
    </div>
  );
};

const mapState = state => {
  return {
    movie: state.selectedMovie.movie,
    ingredients: state.selectedMovie.ingredients,
    recipe_map: state.selectedMovie.recipe_map
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

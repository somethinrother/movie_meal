import React, { useEffect } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";

const MovieDetailPage = ({
  getMovieById,
  movieId,
  movie,
  ingredients,
  recipes,
  sorted_recipes
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
        {/* {recipes
          ? recipes.map(recipe => <li key={Math.random()}>{recipe.name}</li>)
          : []} */}
      </ul>
      <ul>
        {sorted_recipes
          ? sorted_recipes.map(sorted_recipe => (
              <li key={Math.random()}>
                {sorted_recipe.recipes}
                {/* {sorted_recipe.mentions_percentage} */}
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
    recipes: state.selectedMovie.recipes,
    sorted_recipes: state.selectedMovie.sorted_recipes
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

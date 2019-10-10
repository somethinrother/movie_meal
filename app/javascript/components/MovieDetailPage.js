import React, { useEffect } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";

const MovieDetailPage = ({
  getMovieById,
  movieId,
  movie,
  ingredients,
  recipes
}) => {
  useEffect(() => {
    getMovieById(movieId);
  }, []);
  {
    console.log(
      recipes && recipes.length > 0 ? recipes.map(recipe => recipe) : []
    );
  }
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
        {recipes
          ? recipes.map(recipe => (
              <li key={Math.random()}>
                {recipe.id}. Recipe, # Mentions {recipe.ingredient_mentions}
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
    recipes: state.selectedMovie.recipes
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

import React, { useEffect, useState } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";
import "./MovieDetailPage.css";

const MovieDetailPage = ({
  getMovieById,
  movieId,
  movie,
  ingredient_map,
  recipe_map
}) => {
  useEffect(() => {
    getMovieById(movieId);

    if (recipe_map && ingredient_map) {
      setRecipes(recipe_map);
      setIngredients(ingredient_map);
    } else {
      setDataCheckCounter(dataCheckCounter + 1);
    }
  }, [dataCheckCounter]);

  const [ingredients, setIngredients] = React.useState(null);
  const [recipes, setRecipes] = React.useState(null);
  const [dataCheckCounter, setDataCheckCounter] = React.useState(0);
  console.log(recipes);
  return (
    <div className="MovieDetailPage">
      {console.log(ingredient_map)}
      <h2 className="movie-title">{movie ? movie.title : []}</h2>
      <Link to={`/movies`}>
        <button>Go Back</button>
      </Link>
      <div className="ingredients-mentioned">
        <h3>Ingredients Mentioned:</h3>
        <ul>
          {ingredients
            ? ingredients.map(ingredient => (
                <li key={Math.random()}>
                  <h4>{ingredient[1].name}</h4>
                  {/* <span> {ingredient[0].mentions} mentions </span> */}
                </li>
              ))
            : []}
        </ul>
        {/* {ingredients
            ? ingredients.map(ingredient => <h4>{ingredient.name}</h4>)
            : []} */}
      </div>
      <div className="recipes-mentioned">
        <h3>Recipes You Can Make Include...</h3>
        <ul>
          {recipes
            ? recipes.map(recipe => (
                <li key={Math.random()}>
                  <h4>{recipe[1].name}</h4> <span></span>{" "}
                  {/* <i>{recipe[1].mentions}</i> */}
                </li>
              ))
            : []}
        </ul>
      </div>
    </div>
  );
};

const mapState = state => {
  return {
    movie: state.selectedMovie.movie,
    ingredient_map: state.selectedMovie.ingredient_map,
    recipe_map: state.selectedMovie.recipe_map
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

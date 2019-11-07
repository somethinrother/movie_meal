import React, { useEffect, useState } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";
import "./MovieDetailPage.css";
import Loader from "./Loader";

const MovieDetailPage = ({
  getMovieById,
  movieId,
  movie,
  ingredient_map,
  recipe_map,
  loading,
  error
}) => {
  useEffect(() => {
    getMovieById(movieId);

    if (!ingredient_map) {
      setIngredients(ingredient_map);
    } else if (!recipe_map) {
      setRecipes(recipe_map);
    } else {
      setDataCheckCounter(dataCheckCounter + 1);
    }
  }, [dataCheckCounter]);

  const [ingredients, setIngredients] = React.useState(null);
  const [recipes, setRecipes] = React.useState(null);
  const [dataCheckCounter, setDataCheckCounter] = React.useState(0);

  if (error) {
    return (
      <div>
        <h1>ERROR!! {error.message}</h1>
      </div>
    );
  }

  if (loading) {
    return (
      <center className="loading-text">
        <Loader />
      </center>
    );
  }

  return (
    <div className="MovieDetailPage">
      <h2 className="movie-title">{movie ? movie.title : []}</h2>
      <Link to={`/movies`}>
        <button>Go Back</button>
      </Link>
      <div className="ingredients-mentioned">
        <h3>Ingredients Mentioned:</h3>
        <ul>
          {ingredient_map
            ? ingredient_map.map(ingredient => (
                <li key={Math.random()}>
                  <h4>{ingredient[1]}</h4>
                  <span> {ingredient[0].mentions} mentions </span>
                </li>
              ))
            : []}
        </ul>
      </div>
      <div className="recipes-mentioned">
        <h3>Recipes You Can Make Include...</h3>
        <ul>
          {recipe_map
            ? recipe_map.map(recipe => (
                <li key={Math.random()}>
                  <h4>{recipe[1]}</h4> <span>Ingredient Mentions:</span>{" "}
                  <i>{recipe[0].mentions.map(mention => mention + " ")}</i>
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
    recipe_map: state.selectedMovie.recipe_map,
    loading: state.loading,
    error: state.error
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

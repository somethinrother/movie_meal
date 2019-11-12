import React, { useEffect, useState } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";
import "./MovieDetailPage.css";
import Loader from "./Loader";
import { IngredientList } from './IngredientList';
import { RecipesList } from './RecipesList';

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
  }, [dataCheckCounter]);

  const [dataCheckCounter] = React.useState(0);

  if (error) {
    return (
      <div>
        <h1>ERROR!!! {error.message}</h1>
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
      <IngredientList ingredients={ingredient_map} />
      <RecipesList recipes={recipe_map} />
    </div>
  );
};

console.log('this is the movie')
console.log(movie)
console.log('this is the ingredient map')
console.log(ingredient_map)
console.log('this is the recipe map')
console.log(recipe_map)
console.log('this is the loading')
console.log(loading)
console.log('this is the error')
console.log(error)

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

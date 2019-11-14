import React, { useEffect, useState } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";
import "./MovieDetailPage.scss";
import Loader from "./Loader";
import { IngredientList } from './IngredientList';
import { RecipesList } from './RecipesList';

const MovieDetailPage = ({
  getMovieById,
  movieId,
  movie,
  ingredients,
  recipes,
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
      <IngredientList ingredients={ingredients} />
      <RecipesList recipes={recipes} />
    </div>
  );
};

const mapState = state => {
  return {
    movie: state.selectedMovie.movie,
    ingredients: state.selectedMovie.ingredients,
    recipes: state.selectedMovie.recipes,
    loading: state.loading,
    error: state.error
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

import React, { useEffect } from "react";
import { connect } from "react-redux";
import { Link } from "@reach/router";
import { getMovieById } from "../actions";
import "./MovieDetailPage.css";

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
    <div className="MovieDetailPage">
      <h2 className="movie-title">{movie ? movie["title"] : []}</h2>
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
                  <span> {ingredient[0].mentions} mentions </span>
                  <i>total % {ingredient[0].mentions_percentage}</i>
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
                  <h4>{recipe[1].name}</h4>{" "}
                  <span>mentions: {recipe[0].ingredient_mentions}</span>{" "}
                  <i>total % {recipe[0].mentions_percentage}</i>
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
    ingredients: state.selectedMovie.ingredients,
    recipe_map: state.selectedMovie.recipe_map
  };
};
export default connect(
  mapState,
  { getMovieById }
)(MovieDetailPage);

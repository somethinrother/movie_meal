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
  console.log(ingredients);
  return (
    <div className="MovieDetailPage">
      <span>
        <Link to={`/movies`}>
          <button>Go Back</button>
        </Link>
        <h2 className="movie-title">{movie ? movie["title"] : []}</h2>
      </span>
      <h3>Ingredients Mentioned:</h3>
      <ul>
        {ingredients
          ? ingredients.map(ingredient => (
              <li key={Math.random()}>
                <i>{ingredient[1].name}</i>, mentions: {ingredient[0].mentions},
                total % {ingredient[0].mentions_percentage}
              </li>
            ))
          : []}
      </ul>
      <h3>Recipes You Can Make Include...</h3>
      <ul>
        {recipe_map
          ? recipe_map.map(recipe => (
              <li key={Math.random()}>
                <i>{recipe[1].name}</i>, <i>mentions:</i>{" "}
                {recipe[0].ingredient_mentions}, total %{" "}
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

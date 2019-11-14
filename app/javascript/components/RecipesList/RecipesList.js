import React from "react";
import './style.scss';

const RecipesList = ({ recipes }) => {
  return (
    <div className="recipes-mentioned">
      <h3 className='recipe-list-header'>Recipes You Can Make Include...</h3>
      <ul>
        {recipes
          ? recipes.map(recipe => (
              <li key={Math.random()}>
                <h4>{recipe.name}</h4> <span>Ingredient Mentions:</span>{" "}
                <i>{recipe.mentions.map(mention => mention + " ")}</i>
              </li>
            ))
          : []}
      </ul>
    </div>
  );
};

export default RecipesList;
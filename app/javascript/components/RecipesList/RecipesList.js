import React from "react";
import './style.scss';

const RecipesList = ({ recipes }) => {
  return (
    <div className="recipes-mentioned">
      <h3 className='recipe-list-header'>Recipes You Can Make Include...</h3>
      <ul className='recipe-list'>
        {recipes
          ? recipes.map(recipe => (
              <li className='recipe' key={Math.random()}>
                <h4 className='recipe-name'>{recipe.name}</h4>
                <span className='mentions'>Ingredient Mentions:</span>{" "}
                <i className='recipe-mentions'>{recipe.mentions.map(mention => mention + " ")}</i>
              </li>
            ))
          : []}
      </ul>
    </div>
  );
};

export default RecipesList;
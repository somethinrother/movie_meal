import React from "react";

export const RecipesList = ({ recipes }) => {
  return (
    <div className="recipes-mentioned">
      <h3>Recipes You Can Make Include...</h3>
      <ul>
        {recipes
          ? recipes.map(recipe => (
              <li key={Math.random()}>
                <h4>{recipe[1]}</h4> <span>Ingredient Mentions:</span>{" "}
                <i>{recipe[0].mentions.map(mention => mention + " ")}</i>
              </li>
            ))
          : []}
      </ul>
    </div>
  );
};

import React from "react";

export const IngredientList = ({ ingredients }) => {
  return (
    <div className="ingredients-mentioned">
        <h3>Ingredients Mentioned:</h3>
        <ul>
          {ingredients
            ? ingredients.map(ingredient => (
                <li key={Math.random()}>
                  <h4>{ingredient.name}</h4>
                  <span> {ingredient.mentions} mentions </span>
                </li>
              ))
            : []}
        </ul>
      </div>
  );
};

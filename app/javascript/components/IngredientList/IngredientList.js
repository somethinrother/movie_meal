import React from "react";

const IngredientList = ({ ingredients }) => {
  return (
    <div className="ingredients-mentioned">
        <h3>Ingredients Mentioned:</h3>
        <ul>
          {ingredients
            ? ingredients.map(ingredient => (
                <li key={Math.random()}>
                  <h4>{ingredient.name}</h4>
                  <span> {parseInt(ingredient.mentions)} mentions </span>
                </li>
              ))
            : []}
        </ul>
      </div>
  );
};

export default IngredientList;
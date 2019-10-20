import React from "react";
import "./MovieDetailPage.css";

const IngredientList = ({ ingredients }) => {
  return (
    <div className="ingredients-mentioned">
      <h3>Ingredients Mentioned:</h3>
      <ul>
        {ingredients
          ? ingredients.map(ingredient => (
              <li key={Math.random()}>{ingredient.name}</li>
            ))
          : []}
      </ul>
    </div>
  );
};

export default IngredientList;

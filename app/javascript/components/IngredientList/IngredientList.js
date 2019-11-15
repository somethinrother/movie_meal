import React from "react";
import './style.scss'

const IngredientList = ({ ingredients }) => {
  return (
    <div className="ingredients-mentioned">
        <h3 className='ingredient-list-header'>Ingredients Mentioned:</h3>
        <ul>
          {ingredients
            ? ingredients.map(ingredient => (
                <li className='ingredient' key={Math.random()}>
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
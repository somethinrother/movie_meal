import React from "react";
import './style.scss'

const IngredientList = ({ ingredients }) => {
  return (
    <div className="ingredients-mentioned">
        <h3 className='ingredient-list-header'>Ingredients Mentioned:</h3>
        <ul className='ingredient-list'>
          {ingredients
            ? ingredients.map(ingredient => (
                <li className='ingredient' key={Math.random()}>
                  <h4 className='ingredient-name'>{ingredient.name}</h4>
                  <span className='ingredient-mentions'> {parseInt(ingredient.mentions)} mentions </span>
                </li>
              ))
            : []}
        </ul>
      </div>
  );
};

export default IngredientList;
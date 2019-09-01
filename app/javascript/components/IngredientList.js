import React from "react"
import PropTypes from "prop-types"
import { connect } from 'react-redux';
import { createStructuredSelector } from 'reselect';

const GET_INGREDIENTS_REQUEST = 'GET_INGREDIENTS_REQUEST';
const GET_INGREDIENTS_SUCCESS = 'GET_INGREDIENTS_SUCCESS';
const HIDE_INGREDIENTS = 'HIDE_INGREDIENTS';

function getIngredients() {
  return dispatch => {
    dispatch({ type: GET_INGREDIENTS_REQUEST });
    return fetch(`v1/ingredients`)
      .then(response => response.json())
      .then(json => dispatch(getIngredientsSuccess(json)))
      .catch(error => console.log(error));
  }
}

export function getIngredientsSuccess(json) {
  return {
    type: GET_INGREDIENTS_SUCCESS,
    json
  }
}

function hideIngredients() {
  return dispatch => {
    dispatch({ type: HIDE_INGREDIENTS });
  }
}

class IngredientDisplay extends React.Component {
  render () {
    const { ingredients } = this.props;
    const ingredientsList = ingredients.map((ingredient) => {
      return <li key={ingredient.id}>{ingredient.id}. {ingredient.name}</li>
    })

    return (
      <React.Fragment>
        <div>
          <button className="button" onClick={() => this.props.getIngredients()}>Get Ingredients</button>
          <button className="button" onClick={() => this.props.hideIngredients()}>Hide Ingredients</button>
        </div>

        <ul>{ ingredientsList }</ul>
      </React.Fragment>
    );
  }
}

const structuredSelector = createStructuredSelector({
  ingredients: state => state.ingredients
});

const mapDispatchToProps = { getIngredients, hideIngredients };

export default connect(structuredSelector, mapDispatchToProps)(IngredientDisplay);

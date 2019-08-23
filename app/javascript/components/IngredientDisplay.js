import React from "react"
import PropTypes from "prop-types"
import { connect } from 'react-redux';
import { createStructuredSelector } from 'reselect';

const GET_INGREDIENTS_REQUEST = 'GET_INGREDIENTS_REQUEST'

function getIngredients() {
  console.log('getIngredients() Action!!');
  return {
    type: GET_INGREDIENTS_REQUEST
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
        <div>Hi there</div>

        <div>
          <button className="button" onClick={() => this.props.getIngredients()}>Get Ingredients</button>
        </div>

        <ul>{ ingredientsList }</ul>
      </React.Fragment>
    );
  }
}

const structuredSelector = createStructuredSelector({
  ingredients: state => state.ingredients
});

const mapDispatchToProps = { getIngredients };

export default connect(structuredSelector, mapDispatchToProps)(IngredientDisplay);

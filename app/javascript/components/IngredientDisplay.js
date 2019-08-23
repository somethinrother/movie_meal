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
    return (
      <React.Fragment>
        <div>Hi there</div>

        <button className="button" onClick={() => this.props.getIngredients()}>Get Ingredients</button>
      </React.Fragment>
    );
  }
}

const structuredSelector = createStructuredSelector({
  ingredients: state => state.ingredients
});

const mapDispatchToProps = { getIngredients };

export default connect(structuredSelector, mapDispatchToProps)(IngredientDisplay);

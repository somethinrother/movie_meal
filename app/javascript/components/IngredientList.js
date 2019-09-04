import React from "react";
import PropTypes from "prop-types";
import { connect } from "react-redux";
import { createStructuredSelector } from "reselect";
import { getIngredients, hideIngredients } from "../actions";

class IngredientList extends React.Component {
  render() {
    const { ingredients } = this.props;
    const ingredientsList =
      ingredients != null
        ? ingredients.map(ingredient => {
            return (
              <li key={ingredient.id}>
                {ingredient.id}. {ingredient.name}
              </li>
            );
          })
        : [];

    return (
      <React.Fragment>
        <div>
          <button
            className="button"
            onClick={() => this.props.getIngredients()}
          >
            Get Ingredients
          </button>
          <button
            className="button"
            onClick={() => this.props.hideIngredients()}
          >
            Hide Ingredients
          </button>
        </div>

        <ul>{ingredientsList}</ul>
      </React.Fragment>
    );
  }
}

const structuredSelector = createStructuredSelector({
  ingredients: state => state.ingredients
});

const mapDispatchToProps = { getIngredients, hideIngredients };

export default connect(
  structuredSelector,
  mapDispatchToProps
)(IngredientList);

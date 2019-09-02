import React from "react";
import PropTypes from "prop-types";
import { connect } from "react-redux";
import { getIngredient } from "../actions";

class IngredientForm extends React.Component {
  render() {
    const { ingredients } = this.props;
    return (
      <React.Fragment>
        <form onSubmit={(id) => getIngredient(id)}>
          <label value="Find Ingredient">
            <input type="text" placeholder="Search By Id" />
          </label>
          <input type="submit" value="Find Ingredient" />
        </form>
        { ingredients }
      </React.Fragment>
    );
  }
}

// make a selector function, put it in the mapStateToProps
// const mapStateToProps = (state, id) => ({
// 	state.ingredients.filter(id => id === ingredient.id)
// });

// const mapDispatchToProps = { getIngredient }

const mapStateToProps = (state, props) => {
  const id = props.id;
  return {
    ingredients: state.ingredients.filter(ingredient => ingredient.id === id)
  };
};

export default connect(mapStateToProps)(IngredientForm);

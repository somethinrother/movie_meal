import React from "react";
import PropTypes from "prop-types";
import { connect } from "react-redux";
import { getIngredient } from "../actions";

class IngredientForm extends React.Component {
  state = {
    id: ""
  };

  handleInputChange = event => {
    this.setState({ id: event.target.value });
  };

  render() {
    const { ingredients } = this.props;
    return (
      <React.Fragment>
        <form
          onSubmit={event => {
            event.preventDefault();
            this.props.getIngredient(this.state.id);
          }}
        >
          <label value="Find Ingredient">
            <input
              type="text"
              placeholder="Search By Id"
              onChange={this.handleInputChange}
              value={this.state.id}
            />
          </label>
          <input type="submit" value="Find Ingredient" />
        </form>
        {ingredients}
      </React.Fragment>
    );
  }
}

const mapDispatchToProps = { getIngredient };

const mapStateToProps = (state, ownProps) => {
  const id = ownProps.id;
  console.log(state);
  return {
    ingredients: state.ingredients.filter(ingredient => ingredient.id.toString() === id)
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(IngredientForm);

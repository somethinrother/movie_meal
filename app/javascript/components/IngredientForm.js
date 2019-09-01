import React from 'react';
import { connect } from 'react-redux';

// defined function which takes product id as an argument
const GET_INGREDIENT_REQUEST = 'GET_INGREDIENT_REQUEST';
const GET_INGREDIENT_SUCCESS = 'GET_INGREDIENT_SUCCESS';

function getIngredient(id) {
  return dispatch => {
    dispatch({ type: GET_INGREDIENT_REQUEST, id: id });
    return fetch(`v1/ingredients`)
      .then(response => response.json())
      .then(json => dispatch(getIngredientSuccess(json)))
      .catch(error => console.log(error));
  }
}

class IngredientForm extends React.Component {
	render() {
		const { ingredients } = this.props;
		const ingredientsList = ingredients.map((ingredient) => {
      return <h2 key={ingredient.id}>{ingredient.id}. {ingredient.name}</h2>

		return (
			<React.Fragment>
			<form onSubmit={console.log(getIngredient(this.value));}>
				<label value="Find Ingredient">
					<input type="text" value="name" placeholder="Search By Id" />
				</label>
					<input type="submit" value="Find Ingredient" />
			</form>
			{ ingredientsList }
			</React.Fragment>
		);
	}
}

const mapStateToProps = (state, id) => ({
	state.find( ingredients.map(ingredient => ingredient.id === id))
});

const mapDispatchToProps = { getIngredient }

export default connect(mapStateToProps, mapDispatchToProps)(IngredientForm);

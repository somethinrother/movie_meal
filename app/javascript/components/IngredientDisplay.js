import React from 'react';
import IngredientList from './IngredientList'
import IngredientForm from './IngredientForm'

class IngredientDisplay extends React.Component {
	render() {
		return (
			<React.Fragment>
				<IngredientForm />
				<IngredientList />
			</React.Fragment>
		);
	}
}

export default IngredientDisplay

import React from "react"
import PropTypes from "prop-types"

import { BrowserRouter, Switch, Route } from 'react-router-dom'

import IngredientDisplay from './IngredientDisplay'

class App extends React.Component {
  render () {
    return (
      <BrowserRouter>
        <Switch>
          <Route exact path='/' render={() => ("Home!")} />
          <Route path='/ingredients' render={() => <IngredientDisplay />} />
        </Switch>
      </BrowserRouter>
    );
  }
}

export default App

import React from "react";
import { connect } from "react-redux";
import { getMovie } from "../actions";

class MovieSearch extends React.Component {
  state = {
    movie: ""
  };

  handleInputChange = event => {
    this.setState({ movie: event.target.value });
  };

  render() {
    const { Movie } = this.props;
    return (
      <React.Fragment>
        <form
          onSubmit={event => {
            event.preventDefault();
            getMovie(this.state.movie);
          }}
        >
          <label value="Find Movie">
            <input
              type="text"
              placeholder="Search By Movie Title"
              onChange={this.handleInputChange}
              value={this.state.title}
            />
          </label>
          <input type="submit" value="Find Movie" />
        </form>
        <h1>{Movie}</h1>
      </React.Fragment>
    );
  }
}

const mapStateToProps = state => {
  console.log(state);
  return {
    movie: state.movie
  };
};

const mapDispatchToProps = { getMovie };

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(MovieSearch);

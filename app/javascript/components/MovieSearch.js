import React, { useState, useEffect, useRef } from "react";
import { connect } from "react-redux";
import _ from "lodash";
import { getMovieByTitle } from "../actions";
import SelectedMovieDisplay from "./SelectedMovieDisplay";

const MovieSearchForm = ({ getMovieByTitle }) => {
  const [movieTitle, setMovieTitle] = useState("");
  const inputRef = useRef();
  const delayedQuery = useRef(_.debounce(e => getMovieByTitle(e), 500)).current;

  useEffect(() => {
    inputRef.current.focus();
  }, []);

  const onChange = e => {
    setMovieTitle(e.target.value);
    delayedQuery(e.target.value);
  };

  const handleSubmit = e => {
    e.preventDefault();
    getMovieByTitle(movieTitle);
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>Find A Movie: </label>
        <input
          ref={inputRef}
          type="text"
          placeholder="Input Movie Title"
          value={movieTitle}
          onChange={onChange}
        />
        <button type="submit">Search</button>
      </form>
      <SelectedMovieDisplay />
    </div>
  );
};

export default connect(
  null,
  { getMovieByTitle }
)(MovieSearchForm);

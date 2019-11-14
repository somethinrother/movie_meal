import React from "react";
import "./MovieContainer.scss";

const Loader = () => {
  return (
    <div className="loading-container">
      <center>
        <h1 className="loader-text">Loading..</h1>
        <div className="loader"></div>
      </center>
    </div>
  );
};
export default Loader;

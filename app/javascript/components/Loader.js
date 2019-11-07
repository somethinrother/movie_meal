import React from "react";
import "./MovieContainer.css";

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

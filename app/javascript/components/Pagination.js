import React from "react";
import "./MovieContainer.css";

const Pagination = ({ moviesPerPage, totalPosts, paginate }) => {
  const pageNumbers = [];

  for (let i = 1; i <= Math.ceil(totalPosts / moviesPerPage); i++) {
    pageNumbers.push(i);
  }

  return (
    <span className="pagination">
      {pageNumbers.map(number => (
        <button key={number} onClick={() => paginate(number)}>
          {number}
        </button>
      ))}
    </span>
  );
};

export default Pagination;

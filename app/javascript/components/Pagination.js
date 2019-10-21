import React from "react";
import "./MovieContainer.css";
import _ from "lodash";

const Pagination = ({ totalPosts, moviesPerPage, paginate, currentPage }) => {
  console.log(currentPage);
  const pagesCount = Math.ceil(totalPosts / moviesPerPage);
  if (pagesCount === 1) return null;
  const pages = _.range(1, pagesCount + 1);

  return (
    <nav>
      <ul className="pagination">
        <li className="page-item">&lt;&lt;</li>
        {pages.map(page => (
          <li
            key={page}
            className={page === currentPage ? "page-item active" : "page-item"}
          >
            <a className="page-link" onClick={() => paginate(page)}>
              {page}
            </a>
          </li>
        ))}
        <li className="page-item">&gt;&gt;</li>
      </ul>
    </nav>
  );
};

export default Pagination;

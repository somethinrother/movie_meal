import React from "react";
import "./MovieContainer.scss";

const Pagination = ({ totalPosts, moviesPerPage, paginate, currentPage }) => {
  let startPage = 0;
  let endPage = 0;
  let pageSize = 10;

  const totalPages = Math.ceil(totalPosts / moviesPerPage);
  if (totalPages === 1) return null;

  if (currentPage <= 6) {
    startPage = 1;
    endPage = 10;
  } else if (currentPage + 4 >= totalPages) {
    startPage = totalPages - 9;
    endPage = totalPages;
  } else {
    startPage = currentPage - 5;
    endPage = currentPage + 4;
  }

  // // calculate start and end item indexes
  let startIndex = (currentPage - 1) * pageSize;
  let endIndex = Math.min(startIndex + pageSize - 1, totalPosts - 1);

  // create an array of pages to ng-repeat in the pager control
  let pages = [...Array(endPage + 1 - startPage).keys()].map(
    i => startPage + i
  );

  const handleTenClick = () => {
    if (currentPage <= totalPages - 10) {
      paginate(currentPage + 10);
    } else if (currentPage <= totalPages - 5) {
      null;
    } else {
      paginate(currentPage + 1);
    }
  };

  return (
    <nav>
      <ul className="pagination">
        <li className="page-item" onClick={() => paginate(1)}>
          First
        </li>
        <li
          className="page-item"
          onClick={currentPage > 9 ? () => paginate(currentPage - 10) : null}
        >
          &lt;&lt;
        </li>
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
        <li className="page-item" onClick={handleTenClick}>
          &gt;&gt;
        </li>
        <li className="page-item" onClick={() => paginate(totalPages)}>
          Last
        </li>
      </ul>
    </nav>
  );
};

export default Pagination;

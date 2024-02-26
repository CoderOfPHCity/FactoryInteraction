// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


 import "./interfaces/IToken.sol";

contract Library {
    address BookTokenAddress;

    struct Book {
        uint id;
        string title;
        string author;
        bool available;
    }

    struct BorrowRequest {
        uint id;
        address borrower;
        uint bookId;
        bool approved;
    }

    uint bookCount;
    uint requestCount;

    mapping(uint => Book) books;
    mapping(uint => BorrowRequest) borrowRequests;

    event BookAdded(uint indexed id, string title, string author);
    event BookBorrowed(uint indexed id, address indexed borrower, uint bookId);
    event BorrowRequestApproved(uint indexed id);

    constructor(address _bookTokenAddress) {
        BookTokenAddress = _bookTokenAddress;
    }

    function addBook(string memory _title, string memory _author) external {
        require(bytes(_title).length > 0 && bytes(_author).length > 0, "Title and author must not be empty");

        bookCount++;
        books[bookCount] = Book(bookCount, _title, _author, true);

        emit BookAdded(bookCount, _title, _author);
    }

    function borrowBook(uint _bookId) external {
        require(_bookId > 0 && _bookId <= bookCount, "Invalid book ID");

        Book storage book = books[_bookId];
        require(book.available, "Book is not available for borrowing");

        // Transfer book token to contract to borrow book
        IToken(BookTokenAddress).transferFrom(msg.sender, address(this), _bookId);

        book.available = false;

        requestCount++;
        borrowRequests[requestCount] = BorrowRequest(requestCount, msg.sender, _bookId, false);

        emit BookBorrowed(requestCount, msg.sender, _bookId);
    }

    function approveBorrowRequest(uint _requestId) external {
        require(_requestId > 0 && _requestId <= requestCount, "Invalid request ID");

        BorrowRequest storage request = borrowRequests[_requestId];
        require(msg.sender == BookTokenAddress, "Only the Book Token contract can approve requests");
        require(!request.approved, "Request is already approved");

        request.approved = true;

        emit BorrowRequestApproved(_requestId);
    }

    function returnBook(uint _bookId) external {
        require(_bookId > 0 && _bookId <= bookCount, "Invalid book ID");

        Book storage book = books[_bookId];
        require(!book.available, "Book is already available");

        book.available = true;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./Library.sol";

contract LibraryFactory {
    Library[] libraryClones;

    function createLibrary(address _bookTokenAddress) external returns (Library newLibrary_, uint256 length_) {
        newLibrary_ = new Library(_bookTokenAddress);

        libraryClones.push(newLibrary_);

        length_ = libraryClones.length;
    }

    function getLibraries() external view returns (Library[] memory) {
        return libraryClones;
    }
}

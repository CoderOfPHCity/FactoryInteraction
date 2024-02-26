// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../Library.sol";

interface IFactory{

    function createLibrary(address _bookTokenAddress) external returns (Library newLibrary_, uint256 length_);

    function getLibraries() external view returns (Library[] memory);

}
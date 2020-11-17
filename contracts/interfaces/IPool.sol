//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IPool is IERC20 {

    function getCurrentTokens() external view returns (address[] memory);

    function getNormalizedWeight(address token) external view returns (uint);

    function getBalance(address token) external view returns (uint);
}


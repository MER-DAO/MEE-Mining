//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

interface IOracle {
    function requestTokenPrice(address token) external returns(uint8 decimal, uint256 price);
}

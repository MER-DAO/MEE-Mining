//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ILPMining.sol";

contract PriceOracle is Ownable {

    struct PriceInfo {
        uint8 decimal;
        uint256 price;
    }

    // contract governors
    mapping(address => bool) private governors;
    modifier onlyGovernor{
        require(governors[_msgSender()], "PriceOracle: caller is not the governor");
        _;
    }

    mapping(address => bool) public tokenIn;
    // tokens price
    mapping(address => PriceInfo) public tokenPrice;

    // event
    event RequestTokenPrice(address token, uint256 oldPrice);
    event RespondTokenPrice(address token, uint256 oldPrice, uint256 newPrice);

    constructor() public{
        governors[_msgSender()] = true;
    }

    // add governor
    function addGovernor(address governor) onlyOwner external {
        governors[governor] = true;
    }

    // remove governor
    function removeGovernor(address governor) onlyOwner external {
        governors[governor] = false;
    }

    // add token price info
    function addTokenInfo(address token, uint8 _decimal, uint256 _price) onlyOwner public {
        require(!tokenIn[token], "PriceOracle: duplicate token info");
        tokenPrice[token] = PriceInfo({
            decimal : _decimal,
            price : _price
            });
        tokenIn[token] = true;
    }

    //
    function requestTokenPrice(address token) external returns (uint8 decimal, uint256 price){
        decimal = tokenPrice[token].decimal;
        price = tokenPrice[token].price;
        emit RequestTokenPrice(token, price);
    }


    function respondTokenPrice(address token, uint256 newPrice, ILPMining lpMine) onlyGovernor external {
        require(tokenIn[token], "PriceOracle: token not exist");
        uint256 oldPrice = tokenPrice[token].price;
        tokenPrice[token].price = newPrice;
        lpMine.batchSharePools();
        emit RespondTokenPrice(token, oldPrice, newPrice);
    }
}

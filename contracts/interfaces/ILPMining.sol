//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

interface ILPMining {

    function add(address pool, uint256 index, uint256 allocP) external;

    function set(uint256 pid, uint256 allocPoint) external;

    function updateReferenceToken(uint256 pid, uint256 rIndex) external;

    function batchSharePools() external;

    function onTransferLiquidity(address from, address to, uint256 lpAmount) external;

    function claimUserShares(uint pid, address user) external;

    function claimLiquidityShares(address user, address[] calldata tokens, uint256[] calldata balances, uint256[] calldata weights, uint256 amount, bool _add) external;
}

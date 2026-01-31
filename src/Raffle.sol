// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title A sample Raffle contract  
 * @author Nuwan Fernando
 * @notice This contract is for creating a simple raffle
 * @dev Implements Chainlink VRFv2.5
 */
 
contract Raffle {
    /* Errors */
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_entranceFee;
    // @dev The duration of the lottery in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    /* Events */
    event RaffleEntered(address indexed player);


    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
       // require(msg.value >= i_entranceFee, SendMoreToEnterRaffle());
        if (msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));
        // Rule of Thumb: Emit events when storage variables updated.
        // 1. Makes migration easier - (easier redeploy smart contracts)
        // 2. Makes front-end "indexing" easier
        emit RaffleEntered(msg.sender);
    }

    // 1. Get a random number
    // 2. Use random number to pick a winning player
    // 3. Be automatically called
    function pickWinner() external {
        // check to see if enough time has passed
        if((block.timestamp - s_lastTimeStamp) < i_interval){
            revert();
        }
    }

    /** Getter Functions */
    function getEntranceFee() external view returns (uint256 ){
        return i_entranceFee;
    }
}

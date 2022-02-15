// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;


contract Ownable {

    address public owner;

    constructor() {

    owner = msg.sender;    

    }

    modifier OnlyOwner () {

        require( IsOwner(), "you are not the owner");

        _;
    }

    function IsOwner() public view returns (bool) {

        return ( owner == msg.sender);

    }



}
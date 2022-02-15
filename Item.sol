// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;


import "./ItemManager.sol";

contract Item   {

    /* 
    this contract is responsible for taking the payments and handing them back over to the item manager. 
    the whole idea is whenever an new item is created or uploaded on the blockchain, the itme gets its own address, therefore the payer
    will only transfer the money to the Item Address and it will automatically gets transfer to the Item manger SmartContract.
    hence making easier for the payer to make payment
    */

        uint price_in_wei;
        uint index_no;
        uint price_paid;
        ItemManager parent_contract;

        constructor ( ItemManager _parent_contract, uint _price_in_wei, uint _index_no, uint _price_paid ) {

        price_in_wei = _price_in_wei;
        parent_contract = _parent_contract;
        price_paid = _price_paid;
        index_no = _index_no;    
        
       }


       receive () external payable {

        require ( price_paid == 0, "price has allready been paid");
        require ( price_in_wei == msg.value, " only full amounts are accepted");
        price_paid += msg.value;

        // this will transfer the funds from the paying address to the 
        (bool success, ) = address(parent_contract).call{value : msg.value}(abi.encodeWithSignature("triggerPayment (uint256)", index_no));
        require ( success , "the transaction wasn't successfull" );

       }

        fallback () external {}

}

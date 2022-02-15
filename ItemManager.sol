// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "./Ownable.sol"; 
import "./Item.sol";


contract ItemManager  is Ownable {

    enum SupplyChainState {created, paid, delivered} 

    event SupplyChainStep ( uint _ItemIndex , uint _Step );


    struct S_Item {

        uint _identifier;
        uint _price;
        ItemManager.SupplyChainState _state;


    }

       mapping ( uint => S_Item ) public Items ; 

    uint public  ItemIndex;

        function createItem ( uint _identifier, uint _price) public OnlyOwner{

            Items[ItemIndex]._identifier = _identifier;
            Items[ItemIndex]._price = _price;
            Items[ItemIndex]._state = SupplyChainState.created;
            emit SupplyChainStep( ItemIndex, uint (Items[ItemIndex]._state));
            ItemIndex++;

        }


        function triggerPayment (uint _ItemIndex) public payable  {

            require (Items[_ItemIndex]._price == msg.value, "not enough amount paid");
            require (Items[_ItemIndex]._state == SupplyChainState.created, " the product that you are trying to pay for has not been entred in the system");
             emit SupplyChainStep( _ItemIndex, uint (Items[_ItemIndex]._state));
            Items[_ItemIndex]._state  = SupplyChainState.paid;
            


        }


        function triggerDelivery ( uint _ItemIndex) public OnlyOwner {

            require (Items[_ItemIndex]._state  == SupplyChainState.paid, "the item was not paid, please pay the item first" );
            emit SupplyChainStep( _ItemIndex, uint (Items[_ItemIndex]._state));
            Items[_ItemIndex]._state = SupplyChainState.delivered;

       }
 


}
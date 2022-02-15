const ItemManager = artifacts.require("  ItemManager.sol ");

contract  ( "ItemManager", accounts => {

        it("should be able to add an item",  async function(){

               const itemManagerInstance = await ItemManager.deployed();
               const itemName = "item_1";
               const itemPrice = 5000;

              const result = await itemManagerInstance.createItem(itemName, itemPrice,{from:accounts[0]});
             console.log(result);

})

});
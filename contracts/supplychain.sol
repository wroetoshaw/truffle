pragma solidity ^0.8.0;

contract SupplyChain {
    
    address public owner;
    uint public itemCount;
    
    struct Item {
        string name;
        uint quantity;
        uint price;
        bool shipped;
        bool received;
        address payable supplier;
        address payable customer;
    }
    
    mapping (uint => Item) public items;
    
    event ItemCreated(uint id, string name, uint quantity, uint price, address supplier);
    event ItemShipped(uint id);
    event ItemReceived(uint id);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }
    
    function createItem(string memory _name, uint _quantity, uint _price) public {
        itemCount++;
        items[itemCount] = Item(_name, _quantity, _price, false, false, payable(msg.sender), payable(address(0)));
        emit ItemCreated(itemCount, _name, _quantity, _price, msg.sender);
    }
    
    function shipItem(uint _id) public {
        require(items[_id].supplier == msg.sender, "Only the supplier can ship this item");
        require(items[_id].shipped == false, "Item has already been shipped");
        items[_id].shipped = true;
        emit ItemShipped(_id);
    }
    
    function receiveItem(uint _id) public {
        require(items[_id].customer == msg.sender, "Only the customer can receive this item");
        require(items[_id].shipped == true, "Item has not been shipped yet");
        require(items[_id].received == false, "Item has already been received");
        items[_id].received = true;
        items[_id].supplier.transfer(items[_id].price);
        emit ItemReceived(_id);
    }
    
    function getItem(uint _id) public view returns (string memory name, uint quantity, uint price, bool shipped, bool received, address supplier, address customer) {
        Item memory item = items[_id];
        return (item.name, item.quantity, item.price, item.shipped, item.received, item.supplier, item.customer);
    }
    
    function assignCustomer(uint _id, address payable _customer) public onlyOwner {
        require(items[_id].customer == address(0), "Customer has already been assigned for this item");
        items[_id].customer = _customer;
    }
}

pragma solidity 0.4.19;

contract Migrations {
    address public owner;
    uint256 public lastCompletedMigration;

    modifier onlyOwner() {
        require(msg.sender == owner);
        
        _;
    }

    function Migrations()
        public
    {
        owner = msg.sender;
    }

    function setCompleted(uint256 completed)
        public
        onlyOwner
    {
        lastCompletedMigration = completed;
    }

    function upgrade(address newAddress)
        public
        onlyOwner
    {
        Migrations upgraded = Migrations(newAddress);
        upgraded.setCompleted(lastCompletedMigration);
    }
}

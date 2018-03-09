pragma solidity 0.4.19;

contract TestToken {
    address public to;
    uint256 public value;

    // Signature: 72e4268ff12814c79880f2c46ee93300e9ed7b82c92dc6da1d8d6e0daad01bec
    event LogFallback(uint256 indexed _dataLength, bytes _data);

    // Signature: b4f8489f98455c779458fbeec8fd23573741b2ddf095d285b5da07027261f8c0
    event LogTransfer(address indexed _to, uint256 indexed _value, uint256 indexed _dataLength, bytes _data);

    // mitigate short address attack
    // http://vessenes.com/the-erc20-short-address-attack-explained/
    modifier validParamData(uint256 numParams) {
        uint256 expectedDataLength = (numParams * 32) + 4;
        assert(msg.data.length == expectedDataLength);

        _;
    }

    function ()
        public
        payable
    {
        LogFallback(msg.data.length, msg.data);
    }

    function transfer(address _to, uint256 _value)
        public
        validParamData(2)
    {
        to = _to;
        value = _value;
        LogTransfer(_to, _value, msg.data.length, msg.data);
    }
}

pragma solidity 0.4.19;

contract MultiSigWalletHarness {
    struct Transaction {
        address destination;
        uint256 value;
        bytes data;
    }

    Transaction public txn;

    function submitTransaction(address _destination, uint256 _value, bytes _data)
        public
    {
        txn = Transaction({
            destination: _destination,
            value: _value,
            data: _data
        });
    }

    function executeTransaction()
        public
        returns (bool)
    {
        // solhint-disable-next-line avoid-call-value
        bool success = txn.destination.call.value(txn.value)(txn.data);

        return success;
    }

    function executeTransactionWithAssembly()
        public
        returns (bool)
    {
        address _a = txn.destination;
        uint256 _v = txn.value;
        uint256 _insize = txn.data.length;
        bytes memory _data = txn.data;

        bool success;

        // solhint-disable-next-line no-inline-assembly
        assembly {
            // The 10000 below will need to be adjusted to ensure
            // that the calling transaction will always have enough gas remaining
            // to finish its work and return
            let _in := add(_data, 0x20)
            success := call(sub(gas, 10000), _a, _v, _in, _insize, 0, 0)
        }

        return success;
    }
}

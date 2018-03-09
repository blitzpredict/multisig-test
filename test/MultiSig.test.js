const TestToken = artifacts.require("./testHarnesses/TestToken.sol");
const MultiSigWalletHarness = artifacts.require("./testHarnesses/MultiSigWalletHarness.sol");

contract("BPZSmartToken", (accounts) => {
    describe("ERC20 interface:", () => {
        describe("transfer()", () => {
            it("should perform the transfer if called in the Gnosis Multisig wallet style", async () => {
                const testToken = await TestToken.new();
                const walletHarness = await MultiSigWalletHarness.new();

                const transferData = testToken.contract.transfer.getData(
                    "0x1234567890123456789012345678901234567890",
                    1 // 1 wei
                );

                await walletHarness.submitTransaction(testToken.address, 0, transferData);

                const result = await walletHarness.executeTransaction();
                const txn = await walletHarness.txn();
                const to = await testToken.to();
                const value = await testToken.value();

                const results = {
                    transferData,
                    result,
                    txn,
                    to,
                    value
                };

                console.log("Results", JSON.stringify(results, null, 4));
            });

            it("should perform the transfer if called in the Gnosis Multisig wallet style", async () => {
                const testToken = await TestToken.new();
                const walletHarness = await MultiSigWalletHarness.new();

                const transferData = testToken.contract.transfer.getData(
                    "0x1234567890123456789012345678901234567890",
                    1 // 1 wei
                );

                await walletHarness.submitTransaction(testToken.address, 0, transferData);

                const result = await walletHarness.executeTransactionWithAssembly();
                const txn = await walletHarness.txn();
                const to = await testToken.to();
                const value = await testToken.value();

                const results = {
                    transferData,
                    result,
                    txn,
                    to,
                    value
                };

                console.log("Results", JSON.stringify(results, null, 4));
            });
        });
    });
});

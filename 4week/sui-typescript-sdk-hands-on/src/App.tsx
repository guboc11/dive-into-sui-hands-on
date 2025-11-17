import {
  ConnectButton,
  useCurrentAccount,
  useSignAndExecuteTransaction,
} from "@mysten/dapp-kit";
import { Box, Container, Flex, Heading } from "@radix-ui/themes";
import { WalletStatus } from "./WalletStatus";
import { Transaction } from "@mysten/sui/transactions";

function App() {
  const account = useCurrentAccount();
  const { mutate: signAndExecute } = useSignAndExecuteTransaction({});
  return (
    <>
      <Flex
        position="sticky"
        px="4"
        py="2"
        justify="between"
        style={{
          borderBottom: "1px solid var(--gray-a2)",
        }}
      >
        <Box>
          <Heading>dApp Starter Template</Heading>
        </Box>

        <button
          onClick={async () => {
            if (!account) return;

            const tx = new Transaction();

            const [coin] = tx.splitCoins(tx.gas, [100]);
            tx.setGasBudget(10000000);

            tx.transferObjects([coin], tx.pure.address(account.address));

            // tx.moveCall({
            //   package: "0x2",
            //   module: "transfer",
            //   function: "public_transfer",
            //   arguments: [coin, tx.pure.address(account.address)],
            // });

            console.log("transaction!");
            console.log(tx);

            signAndExecute(
              { transaction: tx },
              {
                onError: (err) => {
                  console.log("error!");
                  console.log(err);
                },
                onSuccess: (data) => {
                  console.log("trnasaction success!");
                  console.log(data);
                },
              },
            );
          }}
        >
          Hello
        </button>

        <Box>
          <ConnectButton />
        </Box>
      </Flex>
      <Container>
        <Container
          mt="5"
          pt="2"
          px="4"
          style={{ background: "var(--gray-a2)", minHeight: 500 }}
        >
          <WalletStatus />
        </Container>
      </Container>
    </>
  );
}

export default App;

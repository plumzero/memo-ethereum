package main

import (
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

func main() {

	// conn, err := ethclient.Dial("https://otter.bordel.wtf/erigon")
	conn, err := ethclient.Dial("http://localhost:8545")
	if err != nil {
		log.Fatalf("Failed to connect to the Ethereum client: %v", err)
	}

	defer conn.Close()

	// 生成合约实例，需要填入部署后的合约地址
	demoIns, err := NewCalldemo(common.HexToAddress("0x11Ab452827E6D2E691c61c87c02773901eEE2D75"), conn)
	if err != nil {
		log.Fatalf("Failed to NewCalldemo: %v", err)
	}

	val, err := demoIns.GetCount(nil)
	if err != nil {
		log.Fatalf("Failed to GetCount: %v", err)
	}

	fmt.Println(val)
}

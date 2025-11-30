package main

import (
	"fmt"
	"log"
	"math/big"
	"os"

	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

func main() {
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

	// 利用 keystore 文件生成交易者信息
	keyfile := "/home/tester/geth-ephemery/keystore/UTC--2025-11-23T06-56-20.196250565Z--915e89656d92368f7062d293984998fa5aaa0f3e"
	reader, _ := os.Open(keyfile)
	// 构造交易者消息
	opts, err := bind.NewTransactorWithChainID(reader, "key12341234", big.NewInt(39438153))
	if err != nil {
		log.Fatalf("Failed to NewTransactor: %v", err)
	}
	tx, err := demoIns.SetCount(opts, big.NewInt(2050))
	if err != nil {
		log.Fatalf("Failed to SetCount: %v", err)
	}
	fmt.Printf("%+v\n", tx)
}

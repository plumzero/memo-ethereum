package main

import (
	"context"
	"fmt"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
)

func main() {
	conn, err := ethclient.Dial("ws://localhost:8546")
	if err != nil {
		fmt.Println("Failed to connect to the geth:", err)
		return
	}

	defer conn.Close()

	// 过滤处理
	cAddress := common.HexToAddress("0xce442193837A67355D2e4233d8dfFa601164BB82")
	topicHash1 := crypto.Keccak256Hash([]byte("setAged(address,uint256)"))
	query := ethereum.FilterQuery{
		Addresses: []common.Address{cAddress},
		Topics:    [][]common.Hash{{topicHash1}},
	}

	// 创建日志通道，订阅数据通过此通道写入
	logs := make(chan types.Log)
	// 订阅
	sub, err := conn.SubscribeFilterLogs(context.Background(), query, logs)
	if err != nil {
		fmt.Println("failed to SubscribeFilterLogs", err)
		return
	}

	// 订阅返回处理
	for {
		// select 可以阻塞监控多个 channel
		// 任意一个 channel 有消息，select 解除阻塞，并执行 case 内 channel
		select {
		case err := <-sub.Err():
			fmt.Println("get sub err", err)
		case vLog := <-logs:
			data, err := vLog.MarshalJSON()
			fmt.Println(string(data), err)
		}
	}
}

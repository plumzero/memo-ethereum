#!/usr/bin/env python3

# pip install web3

from web3 import Web3
from eth_account import Account

abi = """[
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_count",
				"type": "uint256"
			}
		],
		"name": "setCount",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "getCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]"""

w3 = Web3(Web3.HTTPProvider('https://otter.bordel.wtf/erigon'))
assert(w3.is_connected())

# setCount 方法调用
addr = '0x11Ab452827E6D2E691c61c87c02773901eEE2D75'
inst = w3.eth.contract(abi=abi, address=addr)
retval = inst.functions.getCount().call()
print("before modified:", retval)

# 加载 keystore 文件(~/geth-ephemery/keystore/UTC--2025-11-23T06-56-20.196250565Z--915e89656d92368f7062d293984998fa5aaa0f3e)
#  解密私钥信息(解密时需要传递之前账户创建时设置的口令)
# acct 是账户地址
keystore = '{"address":"915e89656d92368f7062d293984998fa5aaa0f3e","crypto":{"cipher":"aes-128-ctr","ciphertext":"0c60b89570b4c954a97d8339fb9afc3825dfbd84fdf8482b08a4713fb905b2cd","cipherparams":{"iv":"27d6afc599c88bbe00e0a4da60491431"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"6412cfd0a16245d2cde86a2db940a073821273ed31525103b0840e53cb1f4945"},"mac":"6edf2cff03e70dbdc6ff0a5d6833c63b1be848a3312a8a50fbd776dfdade845e"},"id":"b9f17a5b-d029-436c-80c0-07d9aa4917ed","version":3}'
privatekey = Account.decrypt(keystore, 'key12341234')
acct = Account.from_key(privatekey).address
gasprice = w3.to_wei('2', 'gwei')
nonce = w3.eth.get_transaction_count(acct)

tx = inst.functions.setCount(2025).build_transaction({'gasPrice':gasprice,
                                                     'gas':70000,
                                                     'nonce': nonce,
                                                     'from': acct})
signedtx = w3.eth.account.sign_transaction(tx, private_key=privatekey)
w3.eth.send_raw_transaction(signedtx.raw_transaction)

print('======== ok ========')
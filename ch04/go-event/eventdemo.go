// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package main

import (
	"errors"
	"math/big"
	"strings"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/event"
)

// Reference imports to suppress errors if they are not otherwise used.
var (
	_ = errors.New
	_ = big.NewInt
	_ = strings.NewReader
	_ = ethereum.NotFound
	_ = bind.Bind
	_ = common.Big1
	_ = types.BloomLookup
	_ = event.NewSubscription
	_ = abi.ConvertType
)

// EventdemoMetaData contains all meta data concerning the Eventdemo contract.
var EventdemoMetaData = &bind.MetaData{
	ABI: "[{\"inputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"_owner\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"_age\",\"type\":\"uint256\"}],\"name\":\"setAged\",\"type\":\"event\"},{\"inputs\":[],\"name\":\"adminUser\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"name\",\"type\":\"string\"},{\"internalType\":\"uint256\",\"name\":\"age\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"_age\",\"type\":\"uint256\"}],\"name\":\"setAge\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]",
}

// EventdemoABI is the input ABI used to generate the binding from.
// Deprecated: Use EventdemoMetaData.ABI instead.
var EventdemoABI = EventdemoMetaData.ABI

// Eventdemo is an auto generated Go binding around an Ethereum contract.
type Eventdemo struct {
	EventdemoCaller     // Read-only binding to the contract
	EventdemoTransactor // Write-only binding to the contract
	EventdemoFilterer   // Log filterer for contract events
}

// EventdemoCaller is an auto generated read-only Go binding around an Ethereum contract.
type EventdemoCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// EventdemoTransactor is an auto generated write-only Go binding around an Ethereum contract.
type EventdemoTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// EventdemoFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type EventdemoFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// EventdemoSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type EventdemoSession struct {
	Contract     *Eventdemo        // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// EventdemoCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type EventdemoCallerSession struct {
	Contract *EventdemoCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts    // Call options to use throughout this session
}

// EventdemoTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type EventdemoTransactorSession struct {
	Contract     *EventdemoTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts    // Transaction auth options to use throughout this session
}

// EventdemoRaw is an auto generated low-level Go binding around an Ethereum contract.
type EventdemoRaw struct {
	Contract *Eventdemo // Generic contract binding to access the raw methods on
}

// EventdemoCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type EventdemoCallerRaw struct {
	Contract *EventdemoCaller // Generic read-only contract binding to access the raw methods on
}

// EventdemoTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type EventdemoTransactorRaw struct {
	Contract *EventdemoTransactor // Generic write-only contract binding to access the raw methods on
}

// NewEventdemo creates a new instance of Eventdemo, bound to a specific deployed contract.
func NewEventdemo(address common.Address, backend bind.ContractBackend) (*Eventdemo, error) {
	contract, err := bindEventdemo(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Eventdemo{EventdemoCaller: EventdemoCaller{contract: contract}, EventdemoTransactor: EventdemoTransactor{contract: contract}, EventdemoFilterer: EventdemoFilterer{contract: contract}}, nil
}

// NewEventdemoCaller creates a new read-only instance of Eventdemo, bound to a specific deployed contract.
func NewEventdemoCaller(address common.Address, caller bind.ContractCaller) (*EventdemoCaller, error) {
	contract, err := bindEventdemo(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &EventdemoCaller{contract: contract}, nil
}

// NewEventdemoTransactor creates a new write-only instance of Eventdemo, bound to a specific deployed contract.
func NewEventdemoTransactor(address common.Address, transactor bind.ContractTransactor) (*EventdemoTransactor, error) {
	contract, err := bindEventdemo(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &EventdemoTransactor{contract: contract}, nil
}

// NewEventdemoFilterer creates a new log filterer instance of Eventdemo, bound to a specific deployed contract.
func NewEventdemoFilterer(address common.Address, filterer bind.ContractFilterer) (*EventdemoFilterer, error) {
	contract, err := bindEventdemo(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &EventdemoFilterer{contract: contract}, nil
}

// bindEventdemo binds a generic wrapper to an already deployed contract.
func bindEventdemo(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := EventdemoMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Eventdemo *EventdemoRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Eventdemo.Contract.EventdemoCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Eventdemo *EventdemoRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Eventdemo.Contract.EventdemoTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Eventdemo *EventdemoRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Eventdemo.Contract.EventdemoTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Eventdemo *EventdemoCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Eventdemo.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Eventdemo *EventdemoTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Eventdemo.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Eventdemo *EventdemoTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Eventdemo.Contract.contract.Transact(opts, method, params...)
}

// AdminUser is a free data retrieval call binding the contract method 0xd75eb684.
//
// Solidity: function adminUser() view returns(string name, uint256 age)
func (_Eventdemo *EventdemoCaller) AdminUser(opts *bind.CallOpts) (struct {
	Name string
	Age  *big.Int
}, error) {
	var out []interface{}
	err := _Eventdemo.contract.Call(opts, &out, "adminUser")

	outstruct := new(struct {
		Name string
		Age  *big.Int
	})
	if err != nil {
		return *outstruct, err
	}

	outstruct.Name = *abi.ConvertType(out[0], new(string)).(*string)
	outstruct.Age = *abi.ConvertType(out[1], new(*big.Int)).(**big.Int)

	return *outstruct, err

}

// AdminUser is a free data retrieval call binding the contract method 0xd75eb684.
//
// Solidity: function adminUser() view returns(string name, uint256 age)
func (_Eventdemo *EventdemoSession) AdminUser() (struct {
	Name string
	Age  *big.Int
}, error) {
	return _Eventdemo.Contract.AdminUser(&_Eventdemo.CallOpts)
}

// AdminUser is a free data retrieval call binding the contract method 0xd75eb684.
//
// Solidity: function adminUser() view returns(string name, uint256 age)
func (_Eventdemo *EventdemoCallerSession) AdminUser() (struct {
	Name string
	Age  *big.Int
}, error) {
	return _Eventdemo.Contract.AdminUser(&_Eventdemo.CallOpts)
}

// SetAge is a paid mutator transaction binding the contract method 0xd5dcf127.
//
// Solidity: function setAge(uint256 _age) returns()
func (_Eventdemo *EventdemoTransactor) SetAge(opts *bind.TransactOpts, _age *big.Int) (*types.Transaction, error) {
	return _Eventdemo.contract.Transact(opts, "setAge", _age)
}

// SetAge is a paid mutator transaction binding the contract method 0xd5dcf127.
//
// Solidity: function setAge(uint256 _age) returns()
func (_Eventdemo *EventdemoSession) SetAge(_age *big.Int) (*types.Transaction, error) {
	return _Eventdemo.Contract.SetAge(&_Eventdemo.TransactOpts, _age)
}

// SetAge is a paid mutator transaction binding the contract method 0xd5dcf127.
//
// Solidity: function setAge(uint256 _age) returns()
func (_Eventdemo *EventdemoTransactorSession) SetAge(_age *big.Int) (*types.Transaction, error) {
	return _Eventdemo.Contract.SetAge(&_Eventdemo.TransactOpts, _age)
}

// EventdemoSetAgedIterator is returned from FilterSetAged and is used to iterate over the raw logs and unpacked data for SetAged events raised by the Eventdemo contract.
type EventdemoSetAgedIterator struct {
	Event *EventdemoSetAged // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *EventdemoSetAgedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(EventdemoSetAged)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(EventdemoSetAged)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *EventdemoSetAgedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *EventdemoSetAgedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// EventdemoSetAged represents a SetAged event raised by the Eventdemo contract.
type EventdemoSetAged struct {
	Owner common.Address
	Age   *big.Int
	Raw   types.Log // Blockchain specific contextual infos
}

// FilterSetAged is a free log retrieval operation binding the contract event 0xe086dfe692dbe94902382a0a50d8139c092b8d16790b982f3ff5f7d883616e7e.
//
// Solidity: event setAged(address _owner, uint256 _age)
func (_Eventdemo *EventdemoFilterer) FilterSetAged(opts *bind.FilterOpts) (*EventdemoSetAgedIterator, error) {

	logs, sub, err := _Eventdemo.contract.FilterLogs(opts, "setAged")
	if err != nil {
		return nil, err
	}
	return &EventdemoSetAgedIterator{contract: _Eventdemo.contract, event: "setAged", logs: logs, sub: sub}, nil
}

// WatchSetAged is a free log subscription operation binding the contract event 0xe086dfe692dbe94902382a0a50d8139c092b8d16790b982f3ff5f7d883616e7e.
//
// Solidity: event setAged(address _owner, uint256 _age)
func (_Eventdemo *EventdemoFilterer) WatchSetAged(opts *bind.WatchOpts, sink chan<- *EventdemoSetAged) (event.Subscription, error) {

	logs, sub, err := _Eventdemo.contract.WatchLogs(opts, "setAged")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(EventdemoSetAged)
				if err := _Eventdemo.contract.UnpackLog(event, "setAged", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseSetAged is a log parse operation binding the contract event 0xe086dfe692dbe94902382a0a50d8139c092b8d16790b982f3ff5f7d883616e7e.
//
// Solidity: event setAged(address _owner, uint256 _age)
func (_Eventdemo *EventdemoFilterer) ParseSetAged(log types.Log) (*EventdemoSetAged, error) {
	event := new(EventdemoSetAged)
	if err := _Eventdemo.contract.UnpackLog(event, "setAged", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

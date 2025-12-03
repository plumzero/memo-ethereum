
### 底层调用 call 和 delegatecall 的区别是什么

call 和 delegate 都可以在一个合约 A 内部调用另外一个合约 B 的函数，区别在于两者执行时的上下文环境不同。call 会在被调用合约 B 的上下文中执行对应的函数逻辑，delegatecall 会在当前合约 A 的上下文中执行 B 合约的函数逻辑。这样的区别将导致 call 调用可以修改 B 合约内的数据，而 delegatecall 无法修改 B 合约的数据，但它可以修改 A 合约内的数据。

### 合约间调用时，msg.sender 到底是谁

在进行合约调用时，随着外部账户的切换，msg.sender 也会发生相应的变化。在通过 A 合约调用 B 合约的某个函数时，如果调用的方式是通过 call 函数来调用的，那么 call 函数会将调用消息中的 msg.sender 替换为 A 合约地址，此时在 B 合约内来看，A 就是外部账户。如果使用 degatecall 调用，则不会替换 msg.sender。

普通的接口调用方式与 call 调用是类似的，也会发生 msg.sender 的切换。

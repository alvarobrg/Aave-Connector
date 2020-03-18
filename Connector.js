//JS File for decoding aave functions
import React, { Component } from 'react';
import Web3 from 'web3';
import './App.css';

class App extends Component {

  constructor(props) {
    super(props);
    this.state = {
      account: ''
    }
  }

  async componentWillMount() {
    await this.loadWeb3()
    await this.loadBlockchainData()
  }

  async loadWeb3() {
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider)
    }
    else {
      window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  }

  async loadBlockchainData() {
    const web3 = window.web3

    var aave_deposite_withdraw = {"constant":false,"inputs":[{"name":"_depositeReserve","type":"address"},{"name":"_depositeAmount","type":"uint256"},{"name":"_borrowReserve","type":"address"},{"name":"_borrowAmount","type":"uint256"},{"name":"_interestRateMode","type":"uint256"},{"name":"_referralCode","type":"uint16"}],"name":"borrow","outputs":[],"payable":true,"stateMutability":"payable","type":"function"}
    var aave_args = [
      "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",
      "10000000000000000",
      "0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD",
      "100000000000000",
      1,
      0
    ]


    const data = await web3.eth.abi.encodeFunctionCall(aave_deposite_withdraw, aave_args)
    console.log(data)
  }

  render() {
    return (
      <div>
        Aave Connector
      </div>
    );
  }
}

export default App;

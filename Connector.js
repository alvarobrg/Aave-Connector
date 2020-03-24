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
        "1000000000000000000",
        "0xf80A32A835F79D7787E8a8ee5721D0fEaFd78108",
        "1000000000000000000",
        1,
        0
     ]
    const data = await web3.eth.abi.encodeFunctionCall(aave_deposite_withdraw, aave_args)
    console.log(data)
    
    var params = await web3.utils.asciiToHex("0");
    const aave_flashloan = {"constant":false,"inputs":[{"name":"_receiver","type":"address"},{"name":"_reserve","type":"address"},{"name":"_amount","type":"uint256"},{"name":"_params","type":"bytes"}],"name":"flashLoan","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"  }
    var aave_flashloan_args = [
      "0x69fdf47eb3744920c963e16d0aad1241617abd94",
      "0xf80A32A835F79D7787E8a8ee5721D0fEaFd78108",
      "10000000",
      params
    ]
    const flasLoanData = await web3.eth.abi.encodeFunctionCall(aave_flashloan, aave_flashloan_args)
    console.log(flasLoanData)
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

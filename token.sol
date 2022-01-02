//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Token{
    // mapping
    mapping(address => uint) public balances; // bal will constantly updated

    mapping(address => mapping(address => uint)) public allowance;

    uint public total_supply = 1500;
    string public token_name = "My Token";
    string public symbol = "MTK";
    uint public decimals = 18;

    // event 
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(){
        // send supply of tokens to the address that deployed
        // the smartcontract

        balances[msg.sender] = total_supply;
    }

     // ICO IEO Airdrop (lifecycle will start)
        //  function ( read or modify )

        function balanceOf(address owner) public view  returns(uint) /*Read only*/{
            return balances[owner];
        }

        // BEP-20
        // trnasfer
        function transfer(address to, uint value) public returns(bool){
            require(balanceOf(msg.sender)>= value, 'balance not enough');
            balances[to] += value;
            balances[msg.sender] -= value;
            // smart contracts emit event which external s/w e.g wallet

            emit Transfer(msg.sender, to , value);
            return true;
        }

            // 
        function transferFrom(address from, address to, uint value) public returns(bool){
            require(balanceOf(from) >= value, "balance is too low");
            require(allowance[from][msg.sender] >=value, "allowance too low");
            balances[to] += value;
            balances[from] -= value;
            emit Transfer(from, to, value);
            return true;
        }


        // Delegated Transfer Fn
        function approve(address spender, uint value) public returns(bool){
            allowance[msg.sender][spender] = value;
            emit Approval(msg.sender, spender, value);
            return true;
        }
}

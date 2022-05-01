// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "IERC20.sol";
//contract MyToken is IERC20{
contract MyToken {    

    string public name;
    string public symbol;
    unit public decimal;
    unit public totalSupply;
    mapping(address => uint) balanceOf;
    

    error NotSufficientBalance(address senderAddress, uint balanceToSend, uint availableBalance);
    event Transfer(address indexed from, address indexed to, uint balance);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol, uint _decimal, uint _totalSupply){
        name = _name;
        symbol = _symbol;
        decimal = _decimal;
        totalSupply = _totalSupply;

        balanceOf[msg.sender] = totalSupply;
    } 

    function transferFrom(address from, address to, uint value) external returns(bool){
        if(balanceOf[msg.sender] < value){
            revert NotSufficientBalance(msg.sender, value, balanceOf[from]);
        }
        
       _transfer(msg.sender, to, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool){
        require(balanceOf[msg.sender] >= amount);
        require(bytes(to).length != bytes(msg.sender).length);
        _transfer(msg.sender, to, amount);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
       require(_to != address(0));
        balanceOf[_from] = balanceOf[_from] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);
        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) external returns (bool) {
        require(_spender != address(0));
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
   

}

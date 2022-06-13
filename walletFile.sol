// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Allowance.sol";

contract walletProject is Allowance
{

    event MoneySent(address indexed _benificiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount)
    {
        require(_amount <= address(this).balance, "Not enough balance");
        if(owner() != msg.sender)
        {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public pure override
    {
        revert("Can't renounce ownership here");
    }

    fallback() external payable
    {
        //
    }

    receive() external payable
    {
        emit MoneyReceived(msg.sender, msg.value);
    }
}
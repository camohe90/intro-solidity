//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Arrays{

    uint8[5] public numeros;

    function setData() public{
        numeros[0] = 21;
        numeros[1] = 14;
    }

    function getData() public view returns(uint8[5] memory){
        return numeros;
    }


}
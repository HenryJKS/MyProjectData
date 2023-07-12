// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;
pragma experimental ABIEncoderV2;


// Definir contrato inteligente
contract SimpleStorage {

    //Será inicializado com 0
    uint256 favoriteNumber;

    // Estrutura de um objeto
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // Criando uma lista
    People[] public people;
    //Fazer uma mapping para retornar o favoritenumber pelo nome
    mapping(string => uint256) public nametoFavoriteNumber;

    // função para criar uma pessoa
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber: _favoriteNumber,name: _name}));
        nametoFavoriteNumber[_name] = _favoriteNumber;
    }

    // função para retornar as pessoas adicionada
    function getAllPeople() public view returns (People[] memory) {
        return people;
    }


    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    //view and pure
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }



}

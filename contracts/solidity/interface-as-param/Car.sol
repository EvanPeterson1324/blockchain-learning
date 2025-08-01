pragma solidity ^0.8.28;


// Doesn't implement IAnimal, but has a similar function
contract Car{
    function makeSound() external view returns (string memory) {
        return "Vroom!";
    }
}
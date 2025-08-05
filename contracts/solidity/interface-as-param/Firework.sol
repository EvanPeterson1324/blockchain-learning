pragma solidity ^0.8.28;


// Doesn't implement IAnimal, but has a similar function
contract Firework {
    function makeSound(bool isLoud) external view returns (string memory) {
        if (isLoud) return "BOOM!";
        
        return "boom.";
    }
}
## Overview

Cases

Case #1: Address passed to Zoo.sol is not a contract, and we attempt to call `makeSound()`

Case #2: Address passed to Zoo.sol is a contract that does not extend IAnimal and calls a function with the same function sig.

Case #3: Address passed to Zoo.sol is a contract that doesn not extend IAnimal and
calls a function that it does not define

Case #4: Address passed to Zoo.sol is a contract that does not extend IAnimal and
calls a function that has the same function name with an extra param

How to solve these wierd behaviors? ERC-165?
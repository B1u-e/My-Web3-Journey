// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
// 这个文件保存为 'StructDeclaration.sol'

struct Todo {
    string text;
    bool completed;
}
File that imports the struct above


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./StructDeclaration.sol";

contract Todos {
    // An array of 'Todo' structs
    Todo[] public todos;
}
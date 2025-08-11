// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // 一个 'Todo' 结构体的数组
    Todo[] public todos;

    function create(string calldata _text) public {
        // 有三种初始化结构体的方法
        //  - 像调用函数一样调用它
        todos.push(Todo(_text, false));

        // 键值映射
        todos.push(Todo({text: _text, completed: false}));

        // 初始化一个空的结构体，然后更新它
        Todo memory todo;
        todo.text = _text;
        // todo.completed 初始化为 false

        todos.push(todo);
    }

    // Solidity 自动为 'todos' 创建了一个 getter 函数，你实际上不需要这个函数。
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // 更新文本
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // 更新完成状态
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
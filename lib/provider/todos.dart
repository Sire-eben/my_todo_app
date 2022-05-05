import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog 🐕',
      id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Buy food ',
      id: '',
      description: '''-Eggs
    -Milk
    -Bread
    -Water''',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the cat',
      id: '',
      description: '''-Eggs
    -Milk
    -Bread
    -Water''',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog 🐕',
      id: '',
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}

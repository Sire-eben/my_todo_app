import 'package:flutter/material.dart';
import 'package:my_todo_app/model/todo.dart';
import 'package:my_todo_app/provider/todos.dart';
import 'package:my_todo_app/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? Center(
          child: Text(
              'No tasks',
              style: TextStyle(fontSize: 20),
            ),
        )
        : ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 8,
              );
            },
          );
  }
}

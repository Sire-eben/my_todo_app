import 'package:flutter/material.dart';
import 'package:my_todo_app/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

import '../provider/todos.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;
    return todos.isEmpty
        ? const Center(
            child: Text('No tasks completed', style: TextStyle(fontSize: 20)))
        : ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 8);
            },
          );
  }
}

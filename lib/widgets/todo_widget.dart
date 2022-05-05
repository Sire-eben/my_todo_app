import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo_app/model/todo.dart';
import 'package:my_todo_app/provider/todos.dart';
import 'package:provider/provider.dart';

import '../pages/edit_todo.dart';
import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            key: Key(todo.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  backgroundColor: Colors.green,
                  onPressed: (_) {
                    editTodo(context, todo);
                  },
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.red,
                  onPressed: (_) => deleteTodo(context, todo),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: GestureDetector(
                onTap: (){
                  editTodo(context, todo);
                },
                child: buildTodo(context))),
      );

  Widget buildTodo(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            Checkbox(
              value: todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);

                Utils.showSnackBar(context,
                    isDone ? "Task completetd" : "Task marked incomplete");
              },
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: TextStyle(fontSize: 20, height: 1.5),
                    ),
                  )
              ],
            ))
          ],
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, "Deleted the task");
  }

  void editTodo(BuildContext context, Todo todo) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditTodoPage(todo: todo),
      ));
}

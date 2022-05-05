import 'package:flutter/material.dart';
import 'package:my_todo_app/provider/todos.dart';
import 'package:my_todo_app/widgets/todo_form_widget.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formkey = GlobalKey<FormState>();
  String? title = '';
  String? description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Add Todo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TodoFormWidget(
              onChangedTitle: (title){
                setState(() {
                  this.title = title;
                });
              },
              onChangedDescription: (description){
                setState(() {
                  this.description = description;
                });
              },
              onSavedTodo: addTodo,
            )
          ],
        ),
      ),
    );
  }
  void addTodo(){
    final isValid = _formkey.currentState!.validate();

    if(!isValid){
      return;
    }else{
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title!,
        description: description!,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.pop(context);
    }
  }
}

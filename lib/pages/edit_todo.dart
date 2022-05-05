import 'package:flutter/material.dart';
import 'package:my_todo_app/model/todo.dart';
import 'package:my_todo_app/provider/todos.dart';
import 'package:my_todo_app/widgets/todo_form_widget.dart';
import 'package:provider/provider.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formkey = GlobalKey<FormState>();

  String? title;
  String? description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                provider.removeTodo(widget.todo);

                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: TodoFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() {
              this.title = title;
            }),
            onChangedDescription: (description) => setState(() {
              this.description = description;
            }),
            onSavedTodo: saveTodo,
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _formkey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title!, description!);

      Navigator.pop(context);
    }
  }
}

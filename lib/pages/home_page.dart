import 'package:flutter/material.dart';

import '../widgets/add_todo_dialog.dart';
import '../widgets/completed_list_widget.dart';
import '../widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Todo App"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.white.withOpacity(.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: "Todos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 28,), label: "Completed")
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context,
              builder: (context){
            return const AddTodoDialogWidget();
              },
            barrierDismissible: true,
              );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

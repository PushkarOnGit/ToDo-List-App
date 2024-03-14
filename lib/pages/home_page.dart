import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/components/my_list_tile.dart';
import 'package:todo_list/components/task_item.dart';
import 'package:todo_list/pages/add_task_page.dart';
import 'package:todo_list/pages/completed_tasks_page.dart';
import 'package:todo_list/pages/edit_task_page.dart';
import 'package:todo_list/pages/incomplete_tasks_page.dart';

//class task
class Task {
  final String title;
  final String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //created an object of task as list
  List<Task> tasks = [];

  //add task
  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  //toggle betn complete and incomplete
  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // edit task
  void editTask(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskPage(
          task: tasks[index],
          onSave: (editedTask) {
            setState(() {
              tasks[index] = editedTask;
            });
            Navigator.pop(context); // Close the edit task screen
          },
          onDelete: () {
            deleteTask(index);
            Navigator.pop(context); // Close the edit task screen after deletion
          },
        ),
      ),
    );
  }

  List<Task> get incompleteTasks => tasks.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks => tasks.where((task) => task.isCompleted).toList();



  void onCompletedTasksTap() {
    Navigator.pop(context);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompletedTasksPage(ct: completedTasks),
        ));
  }

  //tap on incomplete tasks
  void onIncompleteTasksTap() {
    Navigator.pop(context);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IncompleteTasksPage(it: incompleteTasks,),
        ));
  }


  //final user
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          children: [
            DrawerHeader(

              child: Column(
                children: [
                  Icon(Icons.person, color:Colors.white, size: 65,),
                  SizedBox(height: 5,),
                  Text(user.email!, style: TextStyle(color: Colors.grey[300]),),
                ],
              ),
            ),
            MyListTile(text: 'Home', icon: Icons.home_filled, onTap: () => Navigator.pop(context),),
            MyListTile(text: 'Completed Tasks', icon: Icons.checklist,onTap: onCompletedTasksTap,),
            MyListTile(text: 'Incomplete Tasks', icon: Icons.data_saver_off, onTap: onIncompleteTasksTap,),
            MyListTile(text: 'Logout', icon: Icons.logout,onTap: () => FirebaseAuth.instance.signOut(),),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage(addTask: addTask)),
          );
        },
      ),

      body:ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: TaskItem(
              task: tasks[index],
              onToggle: () => toggleTaskCompletion(index),
              onDelete: () => deleteTask(index),
              onEdit: () => editTask(index),
            ),
          );
      },
    ),

    );
  }
}


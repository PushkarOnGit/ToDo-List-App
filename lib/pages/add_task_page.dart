import 'package:flutter/material.dart';
import 'package:todo_list/components/my_button.dart';
import 'package:todo_list/components/my_textField.dart';
import 'package:todo_list/pages/home_page.dart';


class AddTaskPage extends StatelessWidget {
  final Function(Task) addTask;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddTaskPage({required this.addTask});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40,),
            MyTextField(controller: titleController, hintText: 'Task', obscureText: false),
            SizedBox(height: 20),
            MyTextField(controller: descriptionController, hintText: 'Description', obscureText: false),
            SizedBox(height: 40),
            MyButton(buttonText: 'Add Task', onTap: (){
              if (titleController.text.isNotEmpty) {
                addTask(Task(
                  title: titleController.text,
                  description: descriptionController.text,
                ));
                Navigator.pop(context);
              }
            },)
          ],
        ),
      ),
    );
  }
}

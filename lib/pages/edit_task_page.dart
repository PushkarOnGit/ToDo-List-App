import 'package:flutter/material.dart';
import 'package:todo_list/components/my_textField.dart';
import 'package:todo_list/pages/home_page.dart';


class EditTaskPage extends StatelessWidget {
  final Task task;
  final Function(Task) onSave;
  final Function() onDelete;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  EditTaskPage({
    required this.task,
    required this.onSave,
    required this.onDelete,
  })  : titleController = TextEditingController(text: task.title),
        descriptionController = TextEditingController(text: task.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40,),

            MyTextField(controller: titleController, hintText: 'Task', obscureText: false),

            SizedBox(height: 20),

            MyTextField(controller: descriptionController, hintText: 'Description', obscureText: false),

            SizedBox(height: 40),

            //save changes button
            GestureDetector(
              onTap: (){
                onSave(
                  Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    isCompleted: task.isCompleted,
                  ),
                );
              },
              child: Container(
                padding:EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

        //delete task button
        GestureDetector(
          onTap: onDelete,
          child: Container(
            padding:EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Center(
              child: Text('Delete Task', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
            
          ],
        ),
      ),
    );
  }
}

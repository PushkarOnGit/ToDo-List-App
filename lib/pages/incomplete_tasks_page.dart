import 'package:flutter/material.dart';
import 'package:todo_list/pages/home_page.dart';

class IncompleteTasksPage extends StatelessWidget {
  final List<Task> it;
  const IncompleteTasksPage({super.key, required this.it});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incompleted Tasks'),
      ),

      body: ListView.builder(
        itemCount: it.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
            child: Material(
              elevation: 3,
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                leading: Icon(Icons.data_saver_off, color: Colors.black,),
                title: Text(it[index].title, style: TextStyle(fontSize: 18)),
                subtitle: Text(it[index].description),
              ),
            ),
          );
        },
      ),
    );
  }
}

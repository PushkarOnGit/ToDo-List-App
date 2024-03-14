import 'package:flutter/material.dart';
import 'package:todo_list/pages/home_page.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  TaskItem({
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 4),
      child: Material(
        elevation: 4,
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          leading: Icon(Icons.games_sharp),
          tileColor:Colors.transparent,
          title: Text(task.title, style: TextStyle(fontSize: 18),),
          subtitle: Text(task.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                activeColor: Colors.green,
                checkColor: Colors.white,
                value: task.isCompleted,
                onChanged: (value) => onToggle(),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.orange,),
                onPressed: () => onEdit(),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red,),
                onPressed: () => onDelete(),
              ),
            ],
          ),
          onTap: () => onEdit(),
          onLongPress: () => onDelete(),
        ),
      ),
    );
  }
}




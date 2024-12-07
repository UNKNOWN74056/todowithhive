import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todowithhive/model/task_model.dart';

class Hiveprovider extends ChangeNotifier {
  final Box<TaskModel> todoBox = Hive.box<TaskModel>('todoBox');
  List<TaskModel> doneTasks = []; // List to store completed tasks

  final TextEditingController customername = TextEditingController();
  final TextEditingController customerphone = TextEditingController();
  final TextEditingController customerhieght = TextEditingController();
  final TextEditingController customerwieght = TextEditingController();

  void deleteTodoItem(int index) {
    todoBox.deleteAt(index); // Remove the task from Hive
    notifyListeners();
  }

  void deleteTodolist(int index) {
    doneTasks.removeAt(index); // Remove the task from Hive
    notifyListeners();
  }

  void addTodoItem(
    String name,
    String phone,
    String hieght,
    String wieght,
  ) {
    if (name.isNotEmpty) {
      final tas =
          TaskModel(name: name, phone: phone, height: hieght, weight: wieght);
      todoBox.add(tas); // Add the task to Hive
      customername.clear();
      customerphone.clear();
      customerhieght.clear();
      customerwieght.clear();
    }
    notifyListeners();
  }

  void markAsDone(int index) {
    // Get the task from the box
    TaskModel? task = todoBox.getAt(index);
    task!.isDone = true;
    todoBox.putAt(index, task);
    doneTasks.add(task);

    notifyListeners();
  }
}

import 'package:hive/hive.dart';

part 'task_model.g.dart'; // Required for code generation

@HiveType(typeId: 0) // Assign a unique type ID
class TaskModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final String height;

  @HiveField(3)
  final String weight;

  @HiveField(4)
  bool isDone;

  TaskModel({
    required this.name,
    required this.phone,
    required this.height,
    required this.weight,
    this.isDone = false,
  });
}

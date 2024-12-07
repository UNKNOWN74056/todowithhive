import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithhive/provider/provider.dart'; // Import your provider
import 'package:todowithhive/model/task_model.dart'; // Import your TaskModel

class DoneTask extends StatelessWidget {
  const DoneTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Done Task"),
      ),
      body: Consumer<Hiveprovider>(
        builder: (context, value, child) {
          // Fetch the done tasks from the provider
          List<TaskModel> doneTasks = value.doneTasks;

          if (doneTasks.isEmpty) {
            return const Center(
              child: Text("No tasks marked as done."),
            );
          }

          return ListView.builder(
            itemCount: doneTasks.length,
            itemBuilder: (context, index) {
              final task = doneTasks[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('$index'),
                        ),
                        title: Text(
                          task.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Phone: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(task.phone),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Height: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("${task.height} FT"),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Weight: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${task.weight} kG'),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Status: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  task.isDone == true ? "Done" : "Pending",
                                  style: TextStyle(
                                    color: task.isDone == true
                                        ? Colors.green
                                        : Colors
                                            .orange, // Set color conditionally
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => value.deleteTodolist(index),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

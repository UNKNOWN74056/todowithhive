import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todowithhive/done_task.dart';
import 'package:todowithhive/provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("BUILDER");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoneTask()));
                },
                icon: const Icon(Icons.check_circle, color: Colors.green)),
          )
        ],
      ),
      body: SingleChildScrollView(
        // Wrap the entire body with SingleChildScrollView
        child: Column(
          // Use Column to lay out the content vertically
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<Hiveprovider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      TextField(
                        controller: value.customername,
                        decoration: InputDecoration(
                          hintText: "Enter your customer name ",
                          labelText: 'Customer name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 10), // Add some spacing

                      TextField(
                        controller: value.customerphone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter customer number e.g: +92",
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      const SizedBox(height: 10), // Add some spacing
                      TextField(
                        controller: value.customerhieght,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter customer height in feet",
                          labelText: 'Height',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      const SizedBox(height: 10), // Add some spacing
                      TextField(
                        controller: value.customerwieght,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter customer weight in kg",
                          labelText: 'Weight',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      const SizedBox(height: 10), // Add some spacing
                      ElevatedButton(
                        onPressed: () => value.addTodoItem(
                            value.customername.text,
                            value.customerphone.text,
                            value.customerhieght.text,
                            value.customerwieght.text),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Circular border
                          ),
                        ),
                        child: const Text('Add Task'),
                      ),
                    ],
                  );
                },
              ),
            ),
            Consumer<Hiveprovider>(
              builder: (context, value, child) {
                return ValueListenableBuilder(
                  valueListenable: value.todoBox.listenable(),
                  builder: (context, Box box, _) {
                    if (box.isEmpty) {
                      return const Center(child: Text('No tasks added yet.'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevents scrolling within ListView
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.5), // Shadow color with opacity
                                    spreadRadius: 1, // Spread radius
                                    blurRadius: 1, // Blur radius
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text('$index'),
                                  ),
                                  title: Text(
                                    box.getAt(index).name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ), // Display title
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Phone: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(box.getAt(index).phone),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Height: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("${box.getAt(index).height} FT"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Weight: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${box.getAt(index).weight} kG'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Status: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            value.todoBox
                                                        .getAt(index)!
                                                        .isDone ==
                                                    false
                                                ? "Pending"
                                                : '',
                                            style: TextStyle(
                                                color: value.todoBox
                                                            .getAt(index)!
                                                            .isDone ==
                                                        false
                                                    ? Colors.orange
                                                    : Colors.green),
                                          )
                                        ],
                                      ),
                                    ],
                                  ), // Display description
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        value.deleteTodoItem(index),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors
                                              .green, // Set text color to white
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12), // Set circular border radius
                                          ),
                                        ),
                                        child: const Text(
                                          "Done",
                                        ),
                                        onPressed: () async {
                                          debugPrint("added to done ist");
                                          value.markAsDone(index);

                                          await Future.delayed(
                                              const Duration(seconds: 2));
                                          value.deleteTodoItem(index);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

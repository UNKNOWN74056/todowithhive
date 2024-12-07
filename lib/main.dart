import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todowithhive/home_page.dart';
import 'package:todowithhive/model/task_model.dart';
import 'package:todowithhive/provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(TaskModelAdapter()); // Register the TaskModel adapter
  await Hive.openBox<TaskModel>('todoBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Hiveprovider>(
          create: (_) => Hiveprovider(),
        )
      ],
      child: MaterialApp(
        title: 'Hive To-Do App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'To Do App'),
      ),
    );
  }
}

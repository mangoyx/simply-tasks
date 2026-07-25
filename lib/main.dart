import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeMode _getThemeMode() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 18) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simply Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 5, 8, 20),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _getThemeMode(),
      home: const MyHomePage(title: 'Simply Tasks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
void initState() {
  super.initState();
  _loadTasks();
}
  final TextEditingController _taskController = TextEditingController();
  List<Task> tasks = [];
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => task.toJson()).toList();
    await prefs.setString('tasks', jsonEncode(taskList));
  }
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskString = prefs.getString('tasks');
    if (taskString != null) {
      final List<dynamic> taskList = jsonDecode(taskString);
      setState(() {
        tasks = taskList.map((json) => Task.fromJson(json)).toList();
      });
    }
  }
  void addTask() {
    setState(() {
      tasks.add(Task(_taskController.text));
      _taskController.clear();
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
  leadingWidth: 96,
  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  centerTitle: true,
  leading: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    hintText: 'Enter task title',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addTask();
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),
    ],
  ),
  title: Text(widget.title),
  actions: [
    IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {},
    ),
  ],
),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index].id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
              _saveTasks();
            },
            background: Container(
              color: const Color.fromARGB(255, 196, 82, 74),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon (
                Icons.keyboard_double_arrow_left,
                color: Colors.white,
              ),
            ),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: CheckboxListTile(
                title: Text(tasks[index].title),
                value: tasks[index].isDone,
                onChanged: (bool? value) {
                  setState(() {
                    tasks[index].isDone = value!;
                });
                  _saveTasks();
              },                   
            ),
          ),
        );
      },                             
    ),
  );
}                                    
}      
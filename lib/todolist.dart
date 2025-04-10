import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// flutter_riverpod: ^2.0.0
// hive: ^2.2.3
// hive_flutter: ^1.1.0

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tasksBox');
  runApp(ProviderScope(child: MyApp()));
}

// 📌 Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoScreen(),
    );
  }
}

// 📌 Task Model
class Task {
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  Map<String, dynamic> toMap() => {'title': title, 'isCompleted': isCompleted};

  factory Task.fromMap(Map<String, dynamic> map) =>
      Task(title: map['title'], isCompleted: map['isCompleted']);
}

// 📌 Task Provider using Riverpod
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final box = Hive.box('tasksBox');
    final taskList = box.get('tasks', defaultValue: []) as List<dynamic>;
    state = taskList.map((task) => Task.fromMap(Map<String, dynamic>.from(task))).toList();
  }

  Future<void> addTask(String title) async {
    final newTask = Task(title: title);
    state = [...state, newTask];
    await _saveTasks();
  }

  Future<void> toggleTask(Task task) async {
    task.isCompleted = !task.isCompleted;
    state = [...state];
    await _saveTasks();
  }

  Future<void> deleteTask(Task task) async {
    state = state.where((t) => t != task).toList();
    await _saveTasks();
  }

  Future<void> _saveTasks() async {
    final box = Hive.box('tasksBox');
    box.put('tasks', state.map((task) => task.toMap()).toList());
  }
}

// 📌 To-Do Screen UI
class TodoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks yet!", style: TextStyle(fontSize: 18)))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return ListTile(
            title: Text(task.title,
                style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(task.isCompleted
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  onPressed: () =>
                      ref.read(taskProvider.notifier).toggleTask(task),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      ref.read(taskProvider.notifier).deleteTask(task),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTaskDialog(context, ref),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(controller: taskController, decoration: InputDecoration(hintText: "Task name")),
        actions: [
          TextButton(
              onPressed: () {
                final taskTitle = taskController.text.trim();
                if (taskTitle.isNotEmpty) {
                  ref.read(taskProvider.notifier).addTask(taskTitle);
                }
                Navigator.pop(context);
              },
              child: Text('Add')),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<String> _todoList = [];
  TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _todoList.add(_controller.text.trim());
        _controller.clear();
      });
    }
  }

  void _editTodo(int index) {
    _controller.text = _todoList[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Todo"),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(hintText: 'Enter updated todo'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _todoList[index] = _controller.text.trim();
                _controller.clear();
              });
              Navigator.of(context).pop();
            },
            child: Text("Update"),
          ),
          TextButton(
            onPressed: () {
              _controller.clear();
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _deleteTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo CRUD App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add Todo
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter a todo",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Text("Add"),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Todo List
            Expanded(
              child: _todoList.isEmpty
                  ? Center(child: Text("No todos yet."))
                  : ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_todoList[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _editTodo(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTodo(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

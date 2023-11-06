import 'package:flutter/material.dart';
import 'package:to_do_app/Pages/Items.dart';

import 'model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoController = TextEditingController();
  List<Model> result = [];
  final todo_list = Model.TodoList();

  @override
  void initState() {
    result = todo_list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent.withOpacity(1),
            title: const Text('To do app'),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/images/background.gif'), // Replace with your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      searchBar(),
                      Expanded(
                          child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 50),
                            child: const Text(
                              "Memory Stack",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          for (Model todoo in result.reversed)
                            Items(
                              todo: todoo,
                              onChanged: _handleChange,
                              onDelete: _delete,
                            ),
                        ],
                      ))
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin:
                            EdgeInsets.only(bottom: 20, right: 20, left: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.pink.shade300,
                                  offset: Offset.zero,
                                  blurRadius: 10.0,
                                  spreadRadius: 0.0)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          controller: _todoController,
                          onSubmitted: (value) {
                            _add(_todoController.text);
                            _todoController.clear();
                          },
                          decoration: InputDecoration(
                              hintText: "Add Task",
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _add(String text) {
    if (text.isEmpty) {
    } else {
      setState(() {
        todo_list.add(Model(
            id: DateTime.now().microsecondsSinceEpoch.toString(), text: text));
      });
    }
  }

  void _handleChange(Model todo) {
    setState(() {
      todo.isComplete = !(todo.isComplete ?? false);
    });
  }

  void _delete(String id) {
    setState(() {
      todo_list.removeWhere((item) => item.id == id);
    });
  }

  void _search(String task) {
    List<Model> items = [];
    if (task.isEmpty) {
      items = todo_list;
    } else {
      items = todo_list
          .where(
              (item) => item.text!.toLowerCase().contains(task.toLowerCase()))
          .toList();
    }
    setState(() {
      result = items;
    });
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _search(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blueGrey,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.teal),
        ),
      ),
    );
  }
}

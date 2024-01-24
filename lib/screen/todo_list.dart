import 'package:flutter/material.dart';
import 'package:todo_app/screen/add_Todo.dart';

import 'package:todo_app/screen/edit_Todo.dart';
import 'package:todo_app/screen/functions.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    getvalues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return getvalues();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return const AddTodo();
              }));
            },
            backgroundColor: const Color.fromARGB(255, 64, 64, 64),
            child: const Text('Add')),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 47, 47, 47),
          centerTitle: true,
          title: const Text(
            'Todo List',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: apinotifier,
            builder: (ctx, items, child) {
              final values = items.toList();
              if (values.isEmpty) {
                return const Center(
                  child: Text('No data'),
                );
              }
              return ListView.builder(
                  itemCount: values.length,
                  itemBuilder: (ctx, index) {
                    final data = values[index];

                    return Card(
                      color: Color.fromARGB(221, 51, 51, 51),
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 11, 11, 11),
                            child: Text((index + 1).toString())),
                        title: Text(data['title']),
                        subtitle: Text(data['description']),
                        trailing: PopupMenuButton(onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return EditTodo(todo: data);
                            }));
                          } else if (value == 'delete') {
                            alertdialogue(context, data['_id'] as String);
                          }
                        }, itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            )
                          ];
                        }),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/screen/functions.dart';

// ignore: must_be_immutable
class EditTodo extends StatefulWidget {
  EditTodo({super.key, required this.todo});
  Map todo;
  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  @override
  void initState() {
    editdescriptioncontroller.text = widget.todo['description'];
    edittitlecontroller.text = widget.todo['title'];
    super.initState();
  }

  TextEditingController edittitlecontroller = TextEditingController();
  TextEditingController editdescriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Todo',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Title'),
          controller: edittitlecontroller,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Description',
          ),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 8,
          controller: editdescriptioncontroller,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () {
              submit(context, widget.todo['_id'].toString());
            },
            child: const Text('Submit')),
      ]),
    );
  }

  submit(context, String id) async {
    final title = edittitlecontroller.text;
    final description = editdescriptioncontroller.text;
    await editdetails(title, description, context, id);
    edittitlecontroller.text = '';
    editdescriptioncontroller.text = '';
  }
}

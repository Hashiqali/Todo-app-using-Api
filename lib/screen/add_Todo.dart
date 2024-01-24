import 'package:flutter/material.dart';
import 'package:todo_app/screen/functions.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
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
          controller: titlecontroller,
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
          controller: descriptioncontroller,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () {
              submit();
            },
            child: const Text('Submit')),
      ]),
    );
  }

  submit() async {
    final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    await adddetails(title, description, context);
    titlecontroller.text = '';
    descriptioncontroller.text = '';
  }
}

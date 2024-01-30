import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

ValueNotifier<List> apinotifier = ValueNotifier([]);

getvalues() async {
  const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';

  final uri = Uri.parse(url);
  final respose = await http.get(uri);

  if (respose.statusCode == 200) {
    final json = jsonDecode(respose.body) as Map;
    final item = json['items'] as List<dynamic>;

    apinotifier.value.clear();
    apinotifier.value.addAll(item);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    apinotifier.notifyListeners();
  }
}

adddetails(String title, String description, context) async {
  final body = {
    "title": title,
    "description": description,
    "is_completed": false,
  };
  const url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  final response = await http.post(uri,
      body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    getvalues();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    // ignore: use_build_context_synchronously
    snakbar(context, 'submitted');
  } else {
    // ignore: use_build_context_synchronously
    snakbar(context, 'Error');
  }
}

editdetails(String title, String description, context, String id) async {
  final body = {
    "title": title,
    "description": description,
    "is_completed": false,
  };
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.put(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode != 404) {
    getvalues();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    snakbar(context, 'submitted');
  } else {
    // ignore: use_build_context_synchronously
    snakbar(context, 'Error');
  }
}

deletesetails(context, String id) async {
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final data = await http.delete(uri);
  if (data.statusCode != 404) {
    await getvalues();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    snakbar(context, 'Deleted');
  } else {
    // ignore: use_build_context_synchronously
    snakbar(context, 'Failed to Delete');
  }
}

snakbar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color.fromARGB(255, 95, 94, 94),
    margin: const EdgeInsets.all(50),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
  ));
}

alertdialogue(context, id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('You want to delete?'),
          actions: [
            TextButton(
                onPressed: () {
                  deletesetails(context, id);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'))
          ],
        );
      });
}

class Todo {
  String? name;
  String? description;
  Todo(this.name, this.description);

  factory Todo.fromjason(Map json) {
    return Todo(json['title'], json['description']);
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/components/dialog_button.dart';

class DialogCreateTask extends StatelessWidget {
  final TextEditingController textFieldController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogCreateTask({
    super.key,
    required this.textFieldController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add new task"),
      actions: [
        DialogButton(text: "Save", onPressed: onSave),
        DialogButton(text: "Cancel", onPressed: onCancel),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
      backgroundColor: Colors.yellow[200],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: textFieldController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "add new task",
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_todo_app/screens/widgets/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;

  final void Function()? task;
  final bool isEdit;
  const DialogBox({
    super.key,
    required this.controller,
    required this.task,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 150,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintText: isEdit ? 'Edit your Task' : 'Enter a new Task',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(onPressed: task, text: isEdit ? 'Edit' : 'Save'),
              const SizedBox(width: 6),
              MyButton(
                  onPressed: () {
                    controller?.clear();
                    Navigator.pop(context);
                  },
                  text: 'Cancel')
            ],
          )
        ]),
      ),
    );
  }
}

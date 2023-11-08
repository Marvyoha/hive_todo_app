import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool taskComplete;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;

  const ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskComplete,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  }) : super(key: key);

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Slidable(
        enabled: true,
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: widget.editFunction,
              icon: Icons.edit,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.green.shade300,
            ),
            const SizedBox(width: 5),
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.red.shade300,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                shape: const CircleBorder(),
                activeColor: Colors.black,
                value: widget.taskComplete,
                onChanged: widget.onChanged,
              ),
              Text(
                widget.taskName,
                style: TextStyle(
                    fontSize: 18,
                    decoration: widget.taskComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

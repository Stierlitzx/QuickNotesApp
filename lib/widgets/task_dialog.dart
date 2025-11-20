import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quick_notes_app/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task? task;
  final Function(Task) onSave;

  const TaskDialog({super.key, this.task, required this.onSave});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {  
  late TextEditingController titleCtrl;
  late TextEditingController descCtrl;
  late TextEditingController timeCtrl;
  late DateTime selectedDate;
  late String selectedStatus;
  late int selectedColor;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.task?.title ?? '');
    descCtrl = TextEditingController(text: widget.task?.description ?? '');
    timeCtrl = TextEditingController(text: widget.task?.time ?? '');
    selectedDate = widget.task?.date ?? DateTime.now();
    selectedStatus = widget.task?.status ?? 'in_progress';
    selectedColor = widget.task?.colorIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: timeCtrl,
              decoration: const InputDecoration(labelText: 'Time (optional)'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: selectedStatus,
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'in_progress', child: Text('In Progress')),
                DropdownMenuItem(value: 'on_hold', child: Text('On Hold')),
                DropdownMenuItem(value: 'completed', child: Text('Completed')),
              ],
              onChanged: (val) => setState(() => selectedStatus = val!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (titleCtrl.text.isEmpty) return;
            
            final task = Task(
              id: widget.task?.id ?? DateTime.now().toString(),
              title: titleCtrl.text,
              description: descCtrl.text,
              date: selectedDate,
              time: timeCtrl.text.isEmpty ? null : timeCtrl.text,
              status: selectedStatus,
              colorIndex: widget.task?.colorIndex ?? selectedColor,
            );
            
            widget.onSave(task);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/storage_service.dart';
import 'dart:math';

class AddEditScreen extends StatefulWidget {
  final Note? existingNote;
  const AddEditScreen({super.key, this.existingNote});
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  final storage = StorageService();

  @override
  void initState() {
    super.initState();
    if (widget.existingNote != null) {
      titleCtrl.text = widget.existingNote!.title;
      contentCtrl.text = widget.existingNote!.content;
    }
  }

  Future<void> _saveNote() async {
    if (titleCtrl.text.isEmpty && contentCtrl.text.isEmpty) {
      Navigator.pop(context);
      return;
    }

    if (widget.existingNote != null) {
      final updatedNote = Note(
        id: widget.existingNote!.id,
        title: titleCtrl.text.isEmpty ? 'Untitled' : titleCtrl.text,
        content: contentCtrl.text,
        createdAt: widget.existingNote!.createdAt,
        colorIndex: widget.existingNote!.colorIndex,
      );
      await storage.updateNote(updatedNote);
    } else {
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleCtrl.text.isEmpty ? 'Untitled' : titleCtrl.text,
        content: contentCtrl.text,
        createdAt: DateTime.now(),
        colorIndex: Random().nextInt(4),
      );
      await storage.addNote(newNote);
    }
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E4F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.existingNote == null ? "Add Note" : "Edit Note",
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: contentCtrl,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: "Write your note...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

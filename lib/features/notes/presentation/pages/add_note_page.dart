import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../categories/presentation/bloc/category_bloc.dart';
import '../../../categories/presentation/bloc/category_state.dart';
import '../../../categories/presentation/bloc/category_event.dart';
import '../../../categories/domain/entities/category.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddNotePage extends StatefulWidget {
  final String categoryId;
  const AddNotePage({super.key, required this.categoryId});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  late String selectedCategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.categoryId;
    context.read<CategoryBloc>().add(LoadCategories());
  }

  void _saveNote() {
    final note = Note(
      id: DateTime.now().toString(),
      title: _titleController.text,
      content: _contentController.text,
      categoryId: selectedCategoryId,
    );

    context.read<NoteBloc>().add(AddNoteEvent(note));
    Navigator.pop(context);
  }

  void _addCategoryDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("New Category"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                context.read<CategoryBloc>().add(
                  AddCategoryEvent(
                    Category(
                      id: DateTime.now().toString(),
                      name: name,
                    ),
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Content"),
            ),
            const SizedBox(height: 10),

            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  return Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedCategoryId,
                          items: state.categories.map((c) {
                            return DropdownMenuItem(
                              value: c.id,
                              child: Text(c.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategoryId = value!;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _addCategoryDialog,
                      )
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _saveNote,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
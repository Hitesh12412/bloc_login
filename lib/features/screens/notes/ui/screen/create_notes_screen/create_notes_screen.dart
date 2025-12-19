import 'package:bloc_login/features/screens/notes/ui/bloc/create_note_bloc/create_note_bloc.dart';
import 'package:bloc_login/features/screens/notes/ui/bloc/create_note_bloc/create_note_event.dart';
import 'package:bloc_login/features/screens/notes/ui/bloc/create_note_bloc/create_note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCreateBloc>(
      create: (context) => NoteCreateBloc(),
      child: const CreateNotesScreenView(),
    );
  }
}

class CreateNotesScreenView extends StatefulWidget {
  const CreateNotesScreenView({super.key});

  @override
  State<CreateNotesScreenView> createState() => _CreateNotesScreenViewState();
}

class _CreateNotesScreenViewState extends State<CreateNotesScreenView> {
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Container(
          padding: const EdgeInsets.only(left: 5),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Add Notes",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade50,
      body: BlocConsumer<NoteCreateBloc, NoteCreateState>(
        listener: (context, state) {
          if (state is NoteCreateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.pop(context, true);
          } else if (state is NoteCreateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Title",
                          style:
                          TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: taskTitleController,
                        decoration: const InputDecoration(
                          hintText: "Enter title",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description",
                          style:
                          TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: taskDescController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Write description...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (taskTitleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter title"),
                            backgroundColor: Colors.red),
                      );
                      return;
                    }

                    context.read<NoteCreateBloc>().add(
                      NoteCreateRequested(
                        noteTitle: taskTitleController.text,
                        description: taskDescController.text,
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: state is NoteCreateLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Add Note",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}


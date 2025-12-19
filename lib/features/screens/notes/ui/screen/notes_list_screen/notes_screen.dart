import 'package:bloc_login/features/screens/notes/ui/bloc/notes_list/note_list_bloc.dart';
import 'package:bloc_login/features/screens/notes/ui/bloc/notes_list/note_list_event.dart';
import 'package:bloc_login/features/screens/notes/ui/bloc/notes_list/note_list_state.dart';
import 'package:bloc_login/features/screens/notes/ui/screen/create_notes_screen/create_notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';

class NotesScreenList extends StatefulWidget {
  const NotesScreenList({super.key});

  @override
  State<NotesScreenList> createState() => _NotesScreenListState();
}

class _NotesScreenListState extends State<NotesScreenList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteListBloc(),
      child: const NotesScreen(userId: "1"),
    );
  }
}

class NotesScreen extends StatefulWidget {
  final String userId;
  const NotesScreen({super.key, required this.userId});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with SingleTickerProviderStateMixin {
  List<dynamic> _pinned = [];
  List<dynamic> _unPinned = [];
  bool _listsInitialized = false;
  bool _pinnedExpanded = false;

  @override
  void initState() {
    BlocProvider.of<NoteListBloc>(context)
        .add(FetchNoteListEvent(userId: widget.userId));
    super.initState();
  }

  String formatDateShort(String iso) {
    try {
      if (iso.isEmpty) return '';
      final d = DateTime.parse(iso);
      return DateFormat('dd/MM/yyyy').format(d);
    } catch (_) {
      return iso;
    }
  }

  String formatDateLong(String iso) {
    try {
      if (iso.isEmpty) return '';
      final d = DateTime.parse(iso);
      return DateFormat('MMM d, yyyy').format(d);
    } catch (_) {
      return iso;
    }
  }

  void _initializeLocalListsIfNeeded(LoadedNoteListState state) {
    if (!_listsInitialized) {
      _pinned = List<dynamic>.from(state.model.data.pinnedNoteList);
      _unPinned = List<dynamic>.from(state.model.data.unPinnedNoteList);
      _listsInitialized = true;
    }
  }


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
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios,
                  size: 20, color: Colors.white)),
        ),
        automaticallyImplyLeading: false,
        title: Row(children: [
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.note_alt_outlined, color: Colors.blue)),
          const SizedBox(width: 10),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Notes",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Your personal notes',
                style: TextStyle(fontSize: 15, color: Colors.white))
          ])
        ]),
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.search, color: Colors.blue)),
          )
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      backgroundColor: Colors.blue.shade50,
      body: Stack(
        children: [
          BlocBuilder<NoteListBloc, NoteListStates>(
            builder: (context, state) {
              if (state is LoadingNoteListState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedNoteListState) {
                _initializeLocalListsIfNeeded(state);
                final hasAny = _pinned.isNotEmpty || _unPinned.isNotEmpty;
                if (!hasAny) return Container();
                return Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),)
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => setState(
                                  () => _pinnedExpanded = !_pinnedExpanded),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(children: [
                              const Expanded(
                                  child: Text('Pinned',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                              Icon(
                                  _pinnedExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.blue),
                            ]),
                          ),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeInOut,
                          alignment: Alignment.topCenter,
                          child: ClipRect(
                            child: Align(
                              heightFactor: _pinnedExpanded ? 1.0 : 0.0,
                              child: Column(
                                children: _pinned.asMap().entries.map((entry) {
                                  final idx = entry.key;
                                  final note = entry.value;
                                  return Column(
                                    children: [
                                      Slidable(
                                        key: Key('pinned_slidable_${note.id}'),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.40,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                              ),
                                              child: const Icon(Icons.share, color: Colors.white, size: 18),
                                            ),

                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                              ),
                                              child: const Icon(Icons.delete, color: Colors.white, size: 18),
                                            ),

                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: Colors.black12),
                                              ),
                                              child: const Icon(Icons.push_pin, color: Colors.black, size: 18),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          (note.title ?? '')
                                                              .toString()
                                                              .isEmpty
                                                              ? 'Untitled'
                                                              : (note.title ?? '')
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                      const SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            formatDateShort(
                                                                (note.createdAt ?? '')
                                                                    .toString()),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black87),),
                                                          const SizedBox(width: 5),
                                                          Text(
                                                              (note.description ?? '')
                                                                  .toString()
                                                                  .isEmpty
                                                                  ? '-'
                                                                  : (note.description ?? '')
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black87)),
                                                        ],
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (idx != _pinned.length - 1)
                                        const Divider(height: 1, indent: 12, endIndent: 12),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 140, top: 8),
                      itemCount: _unPinned.length,
                      itemBuilder: (context, index) {
                        final note = _unPinned[index];
                        final currentDate =
                        formatDateShort((note.createdAt ?? '').toString());
                        final bool isFirstInGroup = index == 0 ||
                            formatDateShort(
                                (_unPinned[index - 1].createdAt ?? '')
                                    .toString()) !=
                                currentDate;
                        return StickyHeader(
                          header: isFirstInGroup
                              ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius:
                                      BorderRadius.circular(12)),
                                  child: Text(
                                      formatDateLong(
                                          (note.createdAt ?? '')
                                              .toString()),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )
                              ])
                              : const SizedBox.shrink(),
                          content: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),)
                                ],),
                            child: Slidable(
                              key: Key('unpinned_slidable_${note.id}'),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.35,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                    child: const Icon(Icons.share, color: Colors.white, size: 18),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Icon(Icons.delete, color: Colors.white, size: 18),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: const Icon(Icons.push_pin, color: Colors.black, size: 18),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              (note.title ?? '').toString().isEmpty
                                                  ? 'Untitled'
                                                  : (note.title ?? '').toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 8),
                                          Text(
                                            (note.description ?? '')
                                                .toString()
                                                .isEmpty
                                                ? '-'
                                                : (note.description ?? '')
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87),),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]);
              } else if (state is FailureNoteListState) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is InternalServerErrorNoteListState) {
                return Center(child: Text(state.error));
              } else if (state is ServerErrorNoteListState) {
                return Center(child: Text(state.error));
              }
              return Container();
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, -4))
              ]),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateNotesScreen(),
                      ),),
                    child: const Text('Add Notes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

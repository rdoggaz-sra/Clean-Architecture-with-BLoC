import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/update_note.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotes getNotes;
  final AddNote addNote;
  final DeleteNote deleteNote;
  final UpdateNote updateNote;

  NoteBloc({
    required this.getNotes,
    required this.addNote,
    required this.deleteNote,
    required this.updateNote
  }) : super(NoteInitial()) {

    on<LoadNotes>((event, emit) async {
      final notes = await getNotes();
      emit(NoteLoaded(notes));
    });

    on<AddNoteEvent>((event, emit) async {
      await addNote(event.note);
      final notes = await getNotes();
      emit(NoteLoaded(notes));
    });

    on<DeleteNoteEvent>((event, emit) async {
      await deleteNote(event.id);
      final notes = await getNotes();
      emit(NoteLoaded(notes));
    });

    on<UpdateNoteEvent>((event, emit) async {
      await updateNote(event.note);
      final notes = await getNotes();
      emit(NoteLoaded(notes));
    });
  }
}
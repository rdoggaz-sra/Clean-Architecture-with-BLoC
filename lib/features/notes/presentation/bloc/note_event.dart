import '../../domain/entities/note.dart';

abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final Note note;
  AddNoteEvent(this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final String id;
  DeleteNoteEvent(this.id);
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;
  UpdateNoteEvent(this.note);
}
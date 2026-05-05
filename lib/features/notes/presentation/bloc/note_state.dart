import 'package:equatable/equatable.dart';
import '../../domain/entities/note.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}
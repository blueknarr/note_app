import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/domain/repository/note_repository.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_ui_event.dart';

import '../../domain/model/note.dart';
import '../../ui/colors.dart';
import 'add_edit_note_event.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  int _color = roseBud.value;

  int get color => _color;

  final _eventController = StreamController<AddEditUiEvent>.broadcast();

  Stream<AddEditUiEvent> get eventStream => _eventController.stream;

  AddEditNoteViewModel(this.repository);

  void onEvent(AddEditNoteEvent event) {
    event.when(
      changeColor: _changeColor,
      saveNote: _saveNote,
    );
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if (id == null) {
      repository.insertNote(Note(
        title: title,
        content: content,
        color: _color,
        timestamp: DateTime.now().microsecondsSinceEpoch,
      ));
    } else {
      await repository.updateNote(Note(
        id: id,
        title: title,
        content: content,
        color: _color,
        timestamp: DateTime.now().microsecondsSinceEpoch,
      ));
    }
    _eventController.add(const AddEditUiEvent.saveNote());
  }
}

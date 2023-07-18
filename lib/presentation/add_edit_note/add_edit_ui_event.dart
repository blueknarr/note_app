import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'add_edit_ui_event.freezed.dart';

@freezed
sealed class AddEditUiEvent with _$AddEditUiEvent {
  const factory AddEditUiEvent.saveNote() = SaveNote;
}

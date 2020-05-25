import 'package:todos_app_core/todos_app_core.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

@immutable
class Todo {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final String userUID;

  Todo(this.task,
      {this.complete = false, String note = '', String id, String userUID = ''})
      : note = note ?? '',
        userUID = userUID ?? '',
        id = id ?? Uuid().generateV4();

  Todo copyWith(
      {bool complete, String id, String note, String task, String userUID}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
      userUID: userUID ?? this.userUID,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^
      task.hashCode ^
      note.hashCode ^
      id.hashCode ^
      userUID.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          userUID == other.userUID &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id, userUID: $userUID}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete, userUID);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(entity.task,
        complete: entity.complete ?? false,
        note: entity.note,
        id: entity.id ?? Uuid().generateV4(),
        userUID: entity.userUID);
  }
}

// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class TodoEntity {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final String userUID;

  TodoEntity(this.task, this.id, this.note, this.complete, this.userUID);

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
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          userUID == other.userUID &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
      'id': id,
      'userUID': userUID
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: $complete, task: $task, note: $note, id: $id, userUID: $userUID}';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
        json['task'] as String,
        json['id'] as String,
        json['note'] as String,
        json['complete'] as bool,
        json['userUID'] as String);
  }
}

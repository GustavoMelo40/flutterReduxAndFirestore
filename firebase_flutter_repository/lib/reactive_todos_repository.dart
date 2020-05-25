// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class FirestoreReactiveTodosRepository implements ReactiveTodosRepository {
  static const String path = 'todo';

  final Firestore firestore;

  const FirestoreReactiveTodosRepository(this.firestore);

  @override
  Future<void> addNewTodo(TodoEntity todo) {
    return firestore.collection(path).document(todo.id).setData(todo.toJson());
  }

  @override
  Future<void> deleteTodo(List<String> idList) async {
    await Future.wait<void>(idList.map((id) {
      return firestore.collection(path).document(id).delete();
    }));
  }

  @override
  Future<Stream<List<TodoEntity>>> todos() async {
    return firestore
        .collection(path)
        .where('userUID', isEqualTo: await userUID)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) {
        return TodoEntity(doc['task'], doc.documentID, doc['note'] ?? '',
            doc['complete'] ?? false, doc['userUID'] ?? '');
      }).toList();
    });
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    return firestore
        .collection(path)
        .document(todo.id)
        .updateData(todo.toJson());
  }

  Future<String> get userUID async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }
}

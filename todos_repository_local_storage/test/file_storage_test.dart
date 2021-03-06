// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:todos_repository_local_storage/todos_repository_local_storage.dart';

void main() {
  group('FileStorage', () {
    final todos = [
      TodoEntity('Task', '1', 'Hallo', false, 'IRThU8sWJOSYPy1gpBKuMc6RPka2')
    ];
    final directory = Directory.systemTemp.createTemp('__storage_test__');
    final storage = FileStorage(
      '_test_tag_',
      () => directory,
    );

    tearDownAll(() async {
      final tempDirectory = await directory;

      tempDirectory.deleteSync(recursive: true);
    });

    test('Should persist TodoEntities to disk', () async {
      final file = await storage.saveTodos(todos);

      expect(file.existsSync(), isTrue);
    });

    test('Should load TodoEntities from disk', () async {
      final loadedTodos = await storage.loadTodos();

      expect(loadedTodos, todos);
    });
  });
}

// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:fire_redux_sample/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:circular_check_box/circular_check_box.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;

  TodoItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.todoItem(todo.id),
      onDismissed: onDismissed,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: new BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          onTap: onTap,
          leading: CircularCheckBox(
            key: ArchSampleKeys.todoItemCheckbox(todo.id),
            value: todo.complete,
            checkColor: Colors.white,
            activeColor: Colors.green,
            inactiveColor: Colors.grey,
            onChanged: onCheckboxChanged,
          ),
          title: Hero(
            tag: '${todo.id}__heroTag',
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                todo.task,
                key: ArchSampleKeys.todoItemTask(todo.id),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

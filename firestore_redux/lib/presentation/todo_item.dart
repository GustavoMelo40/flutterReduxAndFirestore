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
      child: Card(
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          elevation: 4,
          child: ClipPath(
              child: Container(
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
                    trailing: Icon(
                      Icons.notifications,
                      color: todo.complete ? Colors.yellow[600] : Colors.grey,
                      size: 24.0,
                    ),
                    title: Hero(
                      tag: '${todo.id}__heroTag',
                      child: Row(
                        key: ArchSampleKeys.todoItemTask(todo.id),
                        children: <Widget>[
                          Text(
                            '07.00 AM',
                            style: new TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 12.0, height: 12.0),
                          Text(
                            todo.task,
                            style: new TextStyle(
                                color: Colors.deepPurple[800],
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.green, width: 8.0)),
                  )),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)))))),
    );
  }
}

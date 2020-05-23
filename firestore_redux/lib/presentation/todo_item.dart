// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:fire_redux_sample/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;
  final Function onDelete;

  TodoItem({
    @required this.onDelete,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          elevation: 8,
          child: ClipPath(
              child: Container(
                  child: ListTile(
                    onTap: onTap,
                    leading: CircleCheckbox(
                        value: todo.complete,
                        onChanged: onCheckboxChanged,
                        activeColor: Colors.green),
                    trailing: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Tap on Bell!')));
                      },
                      child: Icon(
                        Icons.notifications,
                        color: todo.complete ? Colors.yellow[600] : Colors.grey,
                        size: 24.0,
                      ),
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
                          SizedBox(width: 8.0, height: 8.0),
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
      secondaryActions: <Widget>[
        IconSlideAction(
          key: ArchSampleKeys.deleteTodoButton,
          caption: 'Delete',
          color: Colors.grey[50],
          foregroundColor: Colors.red,
          icon: Icons.delete,
          onTap: () {
            onDelete();
          },
        ),
      ],
    );
  }
}

class CircleCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final bool tristate;
  final MaterialTapTargetSize materialTapTargetSize;

  CircleCheckbox({
    Key key,
    @required this.value,
    this.tristate = false,
    @required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.materialTapTargetSize,
  })  : assert(tristate != null),
        assert(tristate || value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: Checkbox.width,
        height: Checkbox.width,
        child: Container(
          decoration: new BoxDecoration(
            border: Border.all(
                width: 2,
                color: Theme.of(context).unselectedWidgetColor ??
                    Theme.of(context).disabledColor),
            borderRadius: new BorderRadius.circular(100),
          ),
          child: Checkbox(
            value: value,
            tristate: tristate,
            onChanged: onChanged,
            activeColor: activeColor,
            checkColor: checkColor,
            materialTapTargetSize: materialTapTargetSize,
          ),
        ),
      ),
    );
  }
}

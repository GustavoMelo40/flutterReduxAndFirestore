// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:fire_redux_sample/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';

typedef OnSaveCallback = void Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  AddEditScreen(
      {Key key, @required this.onSave, @required this.isEditing, this.todo})
      : super(key: key ?? ArchSampleKeys.addTodoScreen);
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final GlobalKey _fabKeyClose = GlobalKey();
    final double fabSize = MediaQuery.of(context).size.height / 36;
    const double topWidgetHeight = 240.0;

    return Container(
      child: Stack(
        children: <Widget>[
          Card(
              margin: const EdgeInsets.only(top: topWidgetHeight),
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(360, 48),
                topRight: Radius.elliptical(360, 48),
              )),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: isEditing ? widget.todo.task : '',
                        key: ArchSampleKeys.taskField,
                        autofocus: !isEditing,
                        style: textTheme.headline5,
                        decoration: InputDecoration(
                          hintText: localizations.newTodoHint,
                        ),
                        validator: (val) {
                          return val.trim().isEmpty
                              ? localizations.emptyTodoError
                              : null;
                        },
                        onSaved: (value) => _task = value,
                      ),
                      SizedBox(width: 120.0, height: 120.0),
                      GestureDetector(
                        key: isEditing
                            ? ArchSampleKeys.saveTodoFab
                            : ArchSampleKeys.saveNewTodo,
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            widget.onSave(_task, _note);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 48,
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue[200],
                                Colors.blue[800],
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(5, 5),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              isEditing
                                  ? localizations.saveChanges
                                  : localizations.addTodo,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            child: _buildFABClose(context, fabSize, key: _fabKeyClose),
            left: (MediaQuery.of(context).size.width / 2) - fabSize,
            top: topWidgetHeight - fabSize,
          )
        ],
      ),
    );
  }

  Widget _buildFABClose(context, fabSize, {key}) => FloatingActionButton(
        heroTag: "FABClose",
        elevation: 8,
        backgroundColor: Colors.pink,
        key: key,
        onPressed: () => Navigator.pop(context),
        child: Icon(
          Icons.close,
          size: fabSize,
        ),
      );
}

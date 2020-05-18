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
    final double topWidgetHeight = MediaQuery.of(context).size.height / 8;
    final GlobalKey _fabKeyClose = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      // appBar: AppBar(
      //   title: Text(
      //     isEditing ? localizations.editTodo : localizations.addTodo,
      //   ),
      // ),
      body: new Stack(
        children: <Widget>[
          new Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Expanded(
                child: Card(
                    elevation: 0,
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
                            TextFormField(
                              initialValue: isEditing ? widget.todo.note : '',
                              key: ArchSampleKeys.noteField,
                              maxLines: 10,
                              style: textTheme.subtitle1,
                              decoration: InputDecoration(
                                hintText: localizations.notesHint,
                              ),
                              onSaved: (value) => _note = value,
                            )
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
          new Positioned(
            child: _buildFABClose(context, key: _fabKeyClose),
            left: (MediaQuery.of(context).size.width / 2) - 30,
            top: topWidgetHeight - 30,
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   key:
      //       isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
      //   tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
      //   child: Icon(isEditing ? Icons.check : Icons.add),
      //   onPressed: () {
      //     if (_formKey.currentState.validate()) {
      //       _formKey.currentState.save();
      //       widget.onSave(_task, _note);
      //       Navigator.pop(context);
      //     }
      //   },
      // ),
    );
  }

  Widget _buildFABClose(context, {key}) => FloatingActionButton(
        heroTag: "FABClose",
        elevation: 8,
        backgroundColor: Colors.pink,
        key: key,
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.close),
      );
}

// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:fire_redux_sample/containers/active_tab.dart';
import 'package:fire_redux_sample/containers/add_todo.dart';
import 'package:fire_redux_sample/containers/extra_actions_container.dart';
import 'package:fire_redux_sample/containers/filter_selector.dart';
import 'package:fire_redux_sample/containers/filtered_todos.dart';
import 'package:fire_redux_sample/containers/stats.dart';
import 'package:fire_redux_sample/containers/tab_selector.dart';
import 'package:fire_redux_sample/localization.dart';
import 'package:fire_redux_sample/models/models.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: ArchSampleKeys.homeScreen);

  final GlobalKey _fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FirestoreReduxLocalizations.of(context).appTitle),
            actions: [
              FilterSelector(visible: activeTab == AppTab.todos),
              ExtraActionsContainer(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: _buildFAB(context, key: _fabKey),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }

  Widget _buildFAB(context, {key}) => FloatingActionButton(
        heroTag: "FAB",
        elevation: 8,
        backgroundColor: Colors.pink,
        key: key,
        onPressed: () => showDialog(context),
        child: Icon(Icons.add),
      );

  showDialog(BuildContext context) {
    showGeneralDialog(
        barrierLabel: "AddTodo",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 200),
        context: context,
        pageBuilder: (_, __, ___) => Align(
              alignment: Alignment.bottomCenter,
              child: AddTodo(),
            ),
        transitionBuilder: (_, anim, __, child) => SlideTransition(
              position:
                  Tween(begin: Offset(0, 0.5), end: Offset(0, 0)).animate(anim),
              child: child,
            ));
  }
}

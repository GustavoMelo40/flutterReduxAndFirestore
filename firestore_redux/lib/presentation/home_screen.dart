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
  final duration = const Duration(milliseconds: 3000);

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

  Widget _buildTransition(
    BuildContext context,
    Widget page,
    Animation<double> animation,
    Size fabSize,
    Offset fabOffset,
  ) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(0.0),
    );
    final sizeTween = SizeTween(
      begin: fabSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: fabOffset,
      end: Offset.zero,
    );

    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );
    final easeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    );

    final radius = borderTween.evaluate(easeInAnimation);
    final offset = offsetTween.evaluate(animation);
    final size = sizeTween.evaluate(easeInAnimation);

    final transitionFab = Opacity(
      opacity: 1 - easeAnimation.value,
      child: _buildFAB(context),
    );

    Widget positionedClippedChild(Widget child) => Positioned(
        width: size.width / 2,
        height: size.height / 2,
        left: offset.dx / 2,
        top: offset.dy / 2,
        child: ClipRRect(
          borderRadius: radius,
          child: child,
        ));

    return Stack(
      children: [
        positionedClippedChild(page),
        positionedClippedChild(transitionFab),
      ],
    );
  }

  Widget _buildFAB(context, {key}) => FloatingActionButton(
        heroTag: "FAB",
        elevation: 8,
        backgroundColor: Colors.pink,
        key: key,
        onPressed: () => _onFabTap(context),
        child: Icon(Icons.add),
      );

  _onFabTap(BuildContext context) {
    final RenderBox fabRenderBox = _fabKey.currentContext.findRenderObject();
    final fabSize = fabRenderBox.size;
    final fabOffset = fabRenderBox.localToGlobal(Offset.zero);

    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        transitionDuration: duration,
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            AddTodo(),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            new ScaleTransition(
              scale: new Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.00,
                    0.50,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 1.5,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.50,
                      1.00,
                      curve: Curves.linear,
                    ),
                  ),
                ),
                child: child,
              ),
            )));
  }
}

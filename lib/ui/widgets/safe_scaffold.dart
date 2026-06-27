import 'package:flutter/material.dart';

/// A [Scaffold] that automatically wraps [body] in a [SafeArea].
///
/// All other Scaffold parameters are forwarded unchanged.
/// Because [Scaffold] adjusts [MediaQuery.padding.top] to zero for its body
/// when an [AppBar] is present, the [SafeArea] adds no redundant top inset in
/// that case — but correctly adds top inset for screens without an AppBar, and
/// adds left/right/bottom insets in landscape or on devices with a home
/// indicator.
class SafeScaffold extends Scaffold {
  SafeScaffold({
    super.key,
    super.appBar,
    Widget? body,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.persistentFooterAlignment,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary,
    super.drawerDragStartBehavior,
    super.extendBody,
    super.drawerBarrierDismissible,
    super.extendBodyBehindAppBar,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture,
    super.endDrawerEnableOpenDragGesture,
    super.restorationId,
  }) : super(body: body != null ? SafeArea(child: body) : null);
}

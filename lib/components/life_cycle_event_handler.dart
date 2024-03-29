import 'package:flutter/cupertino.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler(
      {required this.resumeCallback, required this.detachedCallback});

  final Function resumeCallback;
  final Function detachedCallback;

  @override
  Future<void> didChangeAppLifeCycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await detachedCallback();
        break;
      case AppLifecycleState.resumed:
        await resumeCallback();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}

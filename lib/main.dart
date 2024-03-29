import 'package:flutter/material.dart';
import 'package:instagram_mobile_flutter/components/life_cycle_event_handler.dart';
import 'package:instagram_mobile_flutter/services/user_service.dart';
import 'package:instagram_mobile_flutter/utils/config.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initFirebase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallback: () => UserService().setUserStatus(true),
        detachedCallback: () => UserService().setUserStatus(false)));
  }

  @override
  Widget build(BuildContext context){
    return MultiProvider(providers: providers, )
  }
}

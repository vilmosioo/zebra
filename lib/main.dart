
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/hive_flutter.dart";

import "common/constants.dart";
import "model/main.dart";
import "model/report.dart";
import "widgets/home.dart";

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const ZebraHomePage(),
    ),
  ],
);

void main() async {
  Hive.registerAdapter(ReportAdapter()); 
  Hive.registerAdapter(MainAdapter()); 
  await Hive.initFlutter();
  await Hive.openBox<Main>(zebraBox);
  runApp(const ZebraApp());
}

class ZebraApp extends StatelessWidget {
  const ZebraApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      title: "Zebra",
=======
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Zebra',
>>>>>>> 4a56a16 (Add home navigation)
      theme: ThemeData(
        primaryColor: const Color.fromARGB(100, 65, 180, 255),
      ),
    );
  }
}

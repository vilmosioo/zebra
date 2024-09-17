
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:url_strategy/url_strategy.dart";

import "common/constants.dart";
import "model/main.dart";
import "model/report.dart";
import "widgets/home.dart";
import "widgets/pages/goal.dart";

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: "home",
      builder: (context, state) => const ZebraHomePage(),
    ),
    GoRoute(
      name: "goal",
      path: "/goals/:goal_name",
      builder: (context, state) => GoalPage(goalName: state.pathParameters["goal_name"] ?? "No goal found",),
    ),
  ],
);

void main() async {
  setPathUrlStrategy();

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
    return MaterialApp.router(
      routerConfig: _router,
      title: "Zebra",
      theme: ThemeData(
        primaryColor: const Color.fromARGB(100, 65, 180, 255),
      ),
    );
  }
}

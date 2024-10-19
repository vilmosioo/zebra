
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:url_strategy/url_strategy.dart";

import "common/constants.dart";
import "model/hive/goal.dart";
import "model/hive/main.dart";
import "model/hive/report.dart";
import "widgets/home.dart";
import "widgets/pages/freedom.dart";
import "widgets/pages/goal.dart";
import "widgets/pages/journey.dart";

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: "home",
      builder: (context, state) => const ZebraHomePage(),
    ),
    GoRoute(
      name: "journey",
      path: "/journey",
      builder: (context, state) => const JourneyPage(),
    ),
    GoRoute(
      name: "freedom",
      path: "/freedom",
      builder: (context, state) => const FreedomPage(),
    ),
    GoRoute(
      name: "goal",
      path: "/goals/:id",
      builder: (context, state) => GoalPage(id: state.pathParameters["id"] ?? "No goal found",),
    ),
  ],
);

void main() async {
  setPathUrlStrategy();

  Hive.registerAdapter(GoalAdapter()); 
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

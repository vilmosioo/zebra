
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

import "../../model/goals.dart";

class GoalPage extends StatelessWidget {
  final GoRouterState? goRouterState;

  const GoalPage({super.key, required this.goRouterState});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoalsModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Zebra"),
        ),
        body: Text(goRouterState?.pathParameters["goal_name"] ?? "No goal found."),
      )
    );
  }
}
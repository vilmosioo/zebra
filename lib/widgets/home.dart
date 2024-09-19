
import "package:flutter/material.dart";

import "pages/goals.dart";
import "upload_button.dart";

class ZebraHomePage extends StatelessWidget {
  const ZebraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zebra"),
      ),
      body: const GoalsPage(),
      floatingActionButton: const UploadButton(),
    );
  }
}
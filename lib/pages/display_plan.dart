import 'package:flutter/material.dart';

class DisplayPlan extends StatelessWidget {
  const DisplayPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("計畫"),
      ),
    );
  }
}

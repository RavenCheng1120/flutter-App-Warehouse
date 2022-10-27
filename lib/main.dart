import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/plan_page.dart';
import 'pages/storage_page.dart';

void main() {
  runApp(const Warehouse());
}

class Warehouse extends StatelessWidget {
  const Warehouse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black87),
        ),
        // scaffoldBackgroundColor: Colors.white,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  final screens = [const HomePage(), const PlanPage(), const StoragePage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("貨倉 Warehouse"),
        leading: IconButton(
          onPressed: () {
            onTabTapped(0);
          },
          icon: const Icon(
            Icons.cabin_rounded,
            size: 30,
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 32,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '首頁',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner_outlined),
            activeIcon: Icon(Icons.document_scanner_rounded),
            label: '計畫',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse_outlined),
            activeIcon: Icon(Icons.warehouse_rounded),
            label: '倉庫',
          ),
        ],
      ),
    );
  }
}

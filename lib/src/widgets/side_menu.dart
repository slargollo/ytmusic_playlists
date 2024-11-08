import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final Widget title;
  final Widget child;
  final Widget? floatingActionButton;

  const SideMenu({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: child,
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
          ],
        ), // Populate the Drawer in the next step.
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

import 'package:flutter/material.dart';

class ThemeDemo extends StatelessWidget {
  const ThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme Demo",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          const Text("Text"),
          const TextField(
            decoration: InputDecoration(hintText: 'Text input'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Elevated button 1'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Elevated button 2'),
          ),
          FilledButton(
            onPressed: () {},
            child: const Text('Filled button'),
          ),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Error button'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

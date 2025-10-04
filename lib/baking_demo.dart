import 'package:flutter/material.dart';

class BakingDemo extends StatelessWidget {
  BakingDemo({super.key});
  final bgColor = const Color(0xFF202020);
  final fgColor = const Color(0xFFFFBD73);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: bgColor,
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // image, 2 of 3
        Expanded(
          flex: 2,
          child: Image.asset(
            'assets/images/baking.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // other widgets 1 of 3
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Spacer(),
              Text('Backing lessons'.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge),
              Text('Master the art of baking'.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall),
              const Spacer(),
              FilledButton.icon(
                onPressed: () {},
                label: const Text('START LEARNING'),
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
                style: FilledButton.styleFrom(
                  backgroundColor: fgColor,
                  foregroundColor: bgColor,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    ));
  }
}

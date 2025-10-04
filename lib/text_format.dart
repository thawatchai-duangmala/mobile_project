import 'package:flutter/material.dart';

class TextFormat extends StatelessWidget {
  const TextFormat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('TextDemo')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HeadLine',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text('BodyText'),
            const Text('BodyText2'),
            FilledButton(
              onPressed: () {},
              child: Text(
                'Button',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

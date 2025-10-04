import 'package:flutter/material.dart';


class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});


  Widget createIconButton() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {},
          color: Colors.red,
        ),
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.android),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        Ink(
          decoration: const ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(color: Colors.green),
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.android),
            color: Colors.green,
            onPressed: () {},
          ),
        ),
      ],
    );
  }


  Widget createOutlinedButton() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {},
          child: const Text('OutlinedButton'),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.amber,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
          child: const Text('OutlinedButton'),
        ),
      ],
    );
  }


  Widget createTextButton() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('TextButton'),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
          child: const Text('TextButton'),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          child: const Text('TextButton'),
        ),
      ],
    );
  }


  Widget createElevatedButton() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Elevated'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.purple,
            elevation: 6,
            shadowColor: Colors.red,
          ),
          child: const Text('Elevated'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Elevated',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }


  Widget createFilledButton() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          onPressed: () {},
          child: const Text('FilledButton'),
        ),
        FilledButton.tonal(
          onPressed: () {},
          child: const Text('FilledButton.tonal'),
        ),
      ],
    );
  }


  Widget createButtonWithIcon() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.fast_forward),
          label: const Text('Skip'),
        ),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.chat_bubble_outline),
          iconAlignment: IconAlignment.end,
          label: const Text('LEARN MORE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            createIconButton(),
            const Divider(),
            createOutlinedButton(),
            const Divider(),
            createTextButton(),
            const Divider(),
            createElevatedButton(),
            const Divider(),
            createFilledButton(),
            const Divider(),
            createButtonWithIcon(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/native/student.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    // get the data from the previous page
    Student data = ModalRoute.of(context)!.settings.arguments as Student;
    // send student become class


    return Scaffold(
      appBar: AppBar(
        title: Text('second route'),
      ),
      body: Column(
        children: [
          Text('Name = ${data.name}'),
          Text('Age = ${data.age}'),
          Text('GPAX =${data.gpax}'),
          Text('Midterm =${data.score[0]}'),
          Text('Final =${data.score[1]}'),

          FilledButton(
            onPressed: () {
              // if push can make overflow need to using pop
              Navigator.pop(context, 'hello');
            },
            child: const Text('back'),
          ),
        ],
      ),
    );
  }
}

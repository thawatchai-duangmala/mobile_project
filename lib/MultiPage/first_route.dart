import 'package:flutter/material.dart';
import 'package:myapp/MultiPage/second_route.dart';
import 'package:myapp/MultiPage/student.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  final tcName = TextEditingController();
  final tcAge = TextEditingController();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First route'),
      ),
      body: Column(
        children: [
          // getting data input of user
          TextField(
            controller: tcName,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: tcAge,
            decoration: InputDecoration(hintText: 'Age'),
          ),
          Text(message),
          FilledButton(
            onPressed: () async {
              // Jump to second page
              message = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecondRoute(),
                  settings: RouteSettings(
                    // arguments: {
                    //   'name': tcName.text,
                    //   'age': tcAge.text,
                    //   'gpax': 3.82,
                    //   'score': [22, 18],
                    // },
                    arguments: Student(
                      tcName.text,
                      int.parse(tcAge.text),
                      3.82,
                      [22, 18],
                    ),
                  ),
                ),
              );
              // this set state will be executed afther we got the data
              setState(() {
                
              });
              // ไม่เเนะนำ
              // Navigator.pushNamed(context, '/two');
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

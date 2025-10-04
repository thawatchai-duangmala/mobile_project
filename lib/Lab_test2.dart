import 'package:flutter/material.dart';

class LabTest2 extends StatefulWidget {
  const LabTest2({super.key});

  @override
  State<LabTest2> createState() => _LabTest2State();
}

class _LabTest2State extends State<LabTest2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tourist Place',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset('assets/images/clock-tower.jpg'),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chiang Rai Clock Tower'),
                        Text('Chiang Rai, Thailand'),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        Text('559'),
                      ],
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.blue,
                        size: 30,
                      ),
                      Text('CALL',style: TextStyle(color: Colors.blue),)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.alt_route_outlined,
                        color: Colors.blue,
                        size: 30,
                      ),
                      Text('ROUTE',style: TextStyle(color: Colors.blue),)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.blue,
                        size: 30,
                      ),
                      Text('SHARE',style: TextStyle(color: Colors.blue),)
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget volutpat velit. Pellentesque at urna id ante pharetra fermentum vitae eget mauris. Ut fringilla erat magna, nec sodales arcu euismod ac. Fusce non pharetra massa. Curabitur et molestie lacus, vitae cursus nunc. Praesent iaculis, turpis vel gravida iaculis, purus mi.'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

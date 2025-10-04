import 'package:flutter/material.dart';

class BrowseApprover extends StatefulWidget {
  const BrowseApprover({super.key});

  @override
  State<BrowseApprover> createState() => _BrowseStudentState();
}

class _BrowseStudentState extends State<BrowseApprover> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Browse list room',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF5B8DBE),
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.home,
              ),
              child: Text('Home',style: TextStyle(fontSize: 11),),
            ),
            Tab(
              icon: Icon(
                Icons.checklist_rounded,
              ),
              child: Text('status',style: TextStyle(fontSize: 11),),
            ),
            Tab(
              icon: Icon(
                Icons.space_dashboard,
              ),
              child: Text('Dashboard',style: TextStyle(fontSize: 11),),
            ),
            Tab(
              icon: Icon(
                Icons.person,
              ),
              child: Text('Profile',style: TextStyle(fontSize: 11),),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // tap1
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Room List',
                                  style: TextStyle(
                                      color: Color(0xFF5B8DBE),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          // room 1
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Image.asset(
                                        'assets/images/TableLargeRoom.png',
                                        width: 150,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const Text('Meeting Room1'),
                                    const Text('Size:Large(20 People)'),
                                    const SizedBox(height: 5)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 3),
                                        child: Row(
                                          children: [
                                            const Text('08:00-10:00'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1),
                                              child: SizedBox(
                                                width: 108,
                                                height: 30,
                                                child: FilledButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red[700],
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text('Disable'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 3),
                                        child: Row(
                                          children: [
                                            const Text('10:00-12:00'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1),
                                              child: SizedBox(
                                                width: 108,
                                                height: 30,
                                                child: FilledButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.amber[700],
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text('Pending'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 3),
                                        child: Row(
                                          children: [
                                            const Text('13:00-15:00'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1),
                                              child: SizedBox(
                                                width: 108,
                                                height: 30,
                                                child: FilledButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green[700],
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text('Free'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 3),
                                        child: Row(
                                          children: [
                                            const Text('15:00-17.00'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1),
                                              child: SizedBox(
                                                width: 108,
                                                height: 30,
                                                child: FilledButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green[700],
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text('Free'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // room2
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Image.asset(
                                          'assets/images/TableSmallRoom.png',
                                          width: 150,
                                          height: 100,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const Text('Meeting Room2'),
                                      const Text('Size:Small(5 People)'),
                                      const SizedBox(height: 5)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('08:00-10:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('10:00-12:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.grey[700],
                                                    ),
                                                    onPressed: () {},
                                                    child:
                                                        const Text('Reserved'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('13:00-15:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('15:00-17.00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // room3
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Image.asset(
                                          'assets/images/TableMediumRoom.png',
                                          width: 150,
                                          height: 100,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const Text('Meeting Room3'),
                                      const Text('Size:Medium(10 People)'),
                                      const SizedBox(height: 5)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('08:00-10:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('10:00-12:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.amber[700],
                                                    ),
                                                    onPressed: () {},
                                                    child:
                                                        const Text('Pending'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('13:00-15:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.amber[700],
                                                    ),
                                                    onPressed: () {},
                                                    child:
                                                        const Text('Pending'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('15:00-17.00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // room4
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Image.asset(
                                          'assets/images/TableMediumRoom.png',
                                          width: 150,
                                          height: 100,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const Text('Meeting Room4'),
                                      const Text('Size:Medium(10 People)'),
                                      const SizedBox(height: 5)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('08:00-10:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.grey[700],
                                                    ),
                                                    onPressed: () {},
                                                    child:
                                                        const Text('Reserved'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('10:00-12:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.grey[700],
                                                    ),
                                                    onPressed: () {},
                                                    child:
                                                        const Text('Reserved'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('13:00-15:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('15:00-17.00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // room 5
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Image.asset(
                                          'assets/images/TableLargeRoom.png',
                                          width: 150,
                                          height: 100,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const Text('Meeting Room5'),
                                      const Text('Size: Large(20 People)'),
                                      const SizedBox(height: 5)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('08:00-10:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('10:00-12:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('13:00-15:00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Row(
                                            children: [
                                              const Text('15:00-17.00'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 30,
                                                  child: FilledButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[700],
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Free'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // tap 2 check status
            const Column(),
            // tap 3 dashboard
            const Column(),
            // tap 4 profile
            const Column()
          ],
        ),
      ),
    );
  }
}

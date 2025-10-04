import 'package:flutter/material.dart';

class DashboardApprover extends StatefulWidget {
  const DashboardApprover({super.key});

  @override
  State<DashboardApprover> createState() => _DashboardApproverState();
}

class _DashboardApproverState extends State<DashboardApprover> {
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
              child: Text(
                'Home',
                style: TextStyle(fontSize: 11),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.checklist_rounded,
              ),
              child: Text(
                'status',
                style: TextStyle(fontSize: 11),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.space_dashboard,
              ),
              child: Text(
                'Dashboard',
                style: TextStyle(fontSize: 11),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.person,
              ),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            const Column(),
            // tap 2 check status
            const Column(),
            //dashboard
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // box1
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Text('Free slot'),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green[700],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '13',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // box2
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Disabled slot'),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.red[700],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            // box3
                            children: [
                              const Text('Pending slot'),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.amber[700],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // box4
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Reserved'),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    )
                  ],
                )
              ],
            ),
            
            // Profile
            const Column()
          ],
        ),
      ),
    );
  }
}
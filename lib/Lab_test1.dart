import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabTest1 extends StatelessWidget {
  const LabTest1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cooking Recipes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Papaya Salad',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      padding: EdgeInsets.all(8),
                      child: const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec libero nisi, congue sed turpis id, tincidunt vehicula felis. Nam dapibus fringilla nibh. Mauris non ornare est, a elementum dui. Suspendisse aliquet, elit vel volutpat congue, turpis tortor malesuada lacus, in feugiat tortor urna nec orci. Duis pretium eros arcu, a."),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Image.asset('assets/images/salad.jpg'),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Icon(Icons.star, color: Colors.amber),
                              Icon(Icons.star, color: Colors.amber),
                              Icon(Icons.star, color: Colors.amber),
                              Icon(Icons.star),
                            ],
                          ),
                          const Text('3128 View'),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 30,
                                    color: Colors.brown,
                                  ),
                                  Text('PREP'),
                                  Text('5 mins')
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.timer_sharp,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  Text('COOK:'),
                                  Text('10 mins')
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.restaurant, size: 30),
                                  Text('FEED:'),
                                  Text('1-3'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

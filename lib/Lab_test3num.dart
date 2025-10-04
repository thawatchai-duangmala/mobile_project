import 'dart:math';

import 'package:flutter/material.dart';

class LabTest3num extends StatefulWidget {
  const LabTest3num({super.key});

  @override
  State<LabTest3num> createState() => _LabTest3numState();
}

class _LabTest3numState extends State<LabTest3num> {
  int randomnum = Random().nextInt(10);
  int num = 0;
  String feedback = '';
  bool fngame = false;
  TextEditingController guessController = TextEditingController();

  void guess() {
    int? guess = int.tryParse(guessController.text);
    if (guess == null) {
      feedback = 'Please enter a valid number.';
      return;
    }
    if (guess == randomnum) {
      feedback = 'Correct, you win!';
    } else if (num == 0) {
      if (guess > randomnum) {
        feedback = '$guess is too large, 2 chance(s) left';
      } else {
        feedback = '$guess is too small, 2 chance(s) left';
      }
      num++;
    } else if (num == 1) {
      if (guess > randomnum) {
        feedback = '$guess is too large, 1 chance(s) left';
      } else {
        feedback = '$guess is too small, 1 chance(s) left';
      }
      num++;
    } else {
      feedback = 'Sorry, you lose. The correct number was $randomnum.';
      fngame = true;
    }
    guessController.clear();
  }

  void resetGame() {
    setState(() {
      randomnum = Random().nextInt(10);
      num = 0;
      feedback = '';
      fngame = false;
      guessController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess a number game'),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: guessController,
                decoration: const InputDecoration(
                  hintText: 'Type your guess number',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  feedback,
                ),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    if (fngame) {
                      resetGame();
                    } else {
                      guess();
                    }
                  });
                },
                child: Text(fngame ? 'Replay' : 'Guess'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

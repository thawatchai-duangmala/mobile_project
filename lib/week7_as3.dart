
import 'package:flutter/material.dart';
import 'dart:math';

class Week7As3 extends StatefulWidget {
  const Week7As3({super.key});

  @override
  State<Week7As3> createState() => _Week7As3State();
}

class _Week7As3State extends State<Week7As3> {
  int randomnum = Random().nextInt(10);
  int num = 0;
  String feedback = '';
  bool fNgame = false;
  TextEditingController guessController = TextEditingController();

  void guess() {
    int? guess = int.tryParse(guessController.text);
    if (guess == null) {
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
      fNgame = true;
    }
    guessController.clear();
  }

  void resetGame() {
    setState(() {
      randomnum = Random().nextInt(10);
      num = 0; 
      feedback = '';
      fNgame = false;
      guessController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess a number game'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: guessController,
                decoration: const InputDecoration(
                  hintText: 'Type any number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                feedback,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  if (fNgame) {
                    resetGame();
                  } else {                  
                    guess();
                  }
                });
              },
              child: Text(fNgame ? 'Replay' : 'Guess'),
            )
          ],
        ),
      ),
    );
  }
}

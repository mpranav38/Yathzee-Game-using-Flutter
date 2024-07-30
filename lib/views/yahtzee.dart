import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
import 'package:mp2/models/scorecard.dart';

import 'package:mp2/views/display_dice.dart';
import 'package:mp2/views/display_scorecard.dart';

class Yahtzee extends StatefulWidget {
  @override
  _YahtzeeState createState() => _YahtzeeState();
}

class _YahtzeeState extends State<Yahtzee> {
  final Dice dice = Dice(5);
  final ScoreCard scoreCard = ScoreCard();
  int rollsLeft = 3;

  void _rollDice() {
    if (rollsLeft > 0) {
      setState(() {
        dice.roll();
        rollsLeft--;
      });
    }
  }

  void _toggleHold(int index) {
    setState(() {
      dice.toggleHold(index);
    });
  }

  void _registerScore(ScoreCategory category) {
    if (dice.values.isNotEmpty && scoreCard[category] == null) {
      scoreCard.registerScore(category, dice.values);
      if (scoreCard.isComplete) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('Final Score: ${scoreCard.total}'),
              actions: <Widget>[
                TextButton(
                  child: Text('Play Again'),
                  onPressed: () {
                    setState(() {
                      scoreCard.clear();
                      dice.clear();
                      rollsLeft = 3;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          rollsLeft = 3;
          dice.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(169, 197, 178, 4),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Rolls Left: $rollsLeft'),
              DiceDisplay(dice: dice, onHold: _toggleHold),
              ElevatedButton(
                onPressed: rollsLeft > 0 ? _rollDice : null,
                child: Text('Roll Dice'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Color.fromARGB(
                          95, 6, 7, 7); // Color when the button is disabled
                    }
                    return Color.fromARGB(
                        230, 21, 12, 199); // Color when the button is active
                  }),
                ),
              ),
              ScoreCardDisplay(
                scoreCard: scoreCard,
                onScoreRegister: _registerScore,
                diceValues: const [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

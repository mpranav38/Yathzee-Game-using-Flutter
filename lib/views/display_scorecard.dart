import 'package:flutter/material.dart';
import 'package:mp2/models/scorecard.dart';

class ScoreCardDisplay extends StatelessWidget {
  final ScoreCard scoreCard;
  final Function(ScoreCategory) onScoreRegister;
  final List<int> diceValues;

  ScoreCardDisplay({
    required this.scoreCard,
    required this.onScoreRegister,
    required this.diceValues,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: ScoreCategory.values.length,
            itemBuilder: (context, index) {
              final category = ScoreCategory.values[index];
              final int potentialScore =
                  scoreCard.potentialScore(category, diceValues);

              return GestureDetector(
                onTap: () => onScoreRegister(category),
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.all(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          // Display the actual score if already scored; if not, show the potential score
                          scoreCard[category]?.toString() ??
                              potentialScore.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Score: ${scoreCard.totalScore}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }
}

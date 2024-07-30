import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';

class DiceDisplay extends StatelessWidget {
  final Dice dice;
  final Function(int) onHold;

  const DiceDisplay({Key? key, required this.dice, required this.onHold})
      : super(key: key);

  Widget _buildDiceButton(int index, BuildContext context) {
    bool isDiceHeld = dice.isHeld(index);
    return GestureDetector(
      onTap: () => onHold(index),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isDiceHeld ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            dice[index]?.toString() ??
                '', // Using null-aware operator for concise syntax
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        // Using List.generate to build dice or empty boxes
        if (index < dice.values.length) {
          return _buildDiceButton(index, context);
        } else {
          // Returning empty boxes for dice not yet added
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                '  ',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          );
        }
      }),
    );
  }
}

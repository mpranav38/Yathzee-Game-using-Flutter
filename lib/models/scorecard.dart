import 'package:collection/collection.dart';

enum ScoreCategory {
  ones("Ones"),
  twos("Twos"),
  threes("Threes"),
  fours("Fours"),
  fives("Fives"),
  sixes("Sixes"),
  threeOfAKind("Three of a Kind"),
  fourOfAKind("Four of a Kind"),
  fullHouse("Full House"),
  smallStraight("Small Straight"),
  largeStraight("Large Straight"),
  yahtzee("Yahtzee"),
  chance("Chance");

  final String name;
  const ScoreCategory(this.name);
}

class ScoreCard {
  final Map<ScoreCategory, int?> _scores = {
    for (var category in ScoreCategory.values) category: null,
  };

  get total => null;

  int? operator [](ScoreCategory category) => _scores[category];

  void registerScore(ScoreCategory category, List<int> dice) {
    if (_scores[category] != null) {
      throw Exception('Score for $category already registered.');
    }
    _scores[category] = potentialScore(category, dice);
  }

  bool get isComplete => _scores.values.every((score) => score != null);
  int get totalScore => _scores.values.whereNotNull().sum;

  int potentialScore(ScoreCategory category, List<int> dice) {
    switch (category) {
      case ScoreCategory.ones:
        return dice.where((d) => d == 1).sum;
      case ScoreCategory.twos:
        return dice.where((d) => d == 2).sum;
      case ScoreCategory.threes:
        return dice.where((d) => d == 3).sum;
      case ScoreCategory.fours:
        return dice.where((d) => d == 4).sum;
      case ScoreCategory.fives:
        return dice.where((d) => d == 5).sum;
      case ScoreCategory.sixes:
        return dice.where((d) => d == 6).sum;
      case ScoreCategory.threeOfAKind:
        return _hasOfAKind(dice, 3) ? dice.sum : 0;
      case ScoreCategory.fourOfAKind:
        return _hasOfAKind(dice, 4) ? dice.sum : 0;
      case ScoreCategory.fullHouse:
        var counts = _diceCounts(dice);
        bool hasThree = counts.containsValue(3);
        bool hasTwo = counts.containsValue(2);
        return (hasThree && hasTwo) ? 25 : 0;
      case ScoreCategory.smallStraight:
        return _hasStraight(dice, 4) ? 30 : 0;
      case ScoreCategory.largeStraight:
        return _hasStraight(dice, 5) ? 40 : 0;
      case ScoreCategory.yahtzee:
        return dice.toSet().length == 1 ? 50 : 0;
      case ScoreCategory.chance:
        return dice.sum;
      default:
        return 0;
    }
  }

  Map<int, int> _diceCounts(List<int> dice) {
    return dice.fold<Map<int, int>>({}, (Map<int, int> counts, int die) {
      counts[die] = (counts[die] ?? 0) + 1;
      return counts;
    });
  }

  bool _hasOfAKind(List<int> dice, int count) {
    var counts = _diceCounts(dice);
    return counts.values.any((c) => c >= count);
  }

  bool _hasStraight(List<int> dice, int length) {
    var uniqueDice = dice.toSet().toList()..sort();
    for (int i = 0; i <= uniqueDice.length - length; i++) {
      var isStraight = true;
      for (int j = 0; j < length - 1; j++) {
        if (uniqueDice[i + j] + 1 != uniqueDice[i + j + 1]) {
          isStraight = false;
          break;
        }
      }
      if (isStraight) return true;
    }
    return false;
  }

  void clear() {
    _scores.forEach((key, value) {
      _scores[key] = null;
    });
  }
}

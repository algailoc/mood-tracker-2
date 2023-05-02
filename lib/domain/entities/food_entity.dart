import 'package:equatable/equatable.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

class FoodEntity extends Equatable {
  final String id;
  final String name;
  final Map<Mood, int> rating;
  final bool original;

  const FoodEntity({
    required this.id,
    required this.name,
    required this.rating,
    this.original = true,
  });

  double get average {
    int sum = 0;
    int count = 0;

    for (var key in rating.keys) {
      late final int multiplier;

      switch (key) {
        case Mood.awful:
          multiplier = 1;
          break;
        case Mood.bad:
          multiplier = 2;
          break;
        case Mood.mediocre:
          multiplier = 3;
          break;
        case Mood.good:
          multiplier = 4;
          break;
        case Mood.great:
          multiplier = 5;
          break;
        default:
          multiplier = 0;
          break;
      }

      count += rating[key]!;
      sum += rating[key]! * multiplier;
    }

    return sum / count;
  }

  FoodEntity copyWith({
    String? name,
    Map<Mood, int>? rating,
    bool? original,
  }) {
    return FoodEntity(
      id: id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      original: original ?? this.original,
    );
  }

  FoodEntity changeRating({required Mood oldMood, required Mood newMood}) {
    return copyWith(
      rating: {
        ...rating,
        oldMood: (rating[oldMood]! - 1),
        newMood: (rating[newMood]! + 1)
      },
    );
  }

  FoodEntity addRating(Mood mood) {
    final newRating = rating;
    newRating[mood] = (newRating[mood] ?? 0) + 1;

    return copyWith(rating: newRating);
  }

  FoodEntity removeRating(Mood mood) {
    final newRating = rating;
    newRating[mood] = (newRating[mood] ?? 1) - 1;

    return copyWith(rating: newRating);
  }

  @override
  List<Object?> get props => [id, name, rating];

  @override
  bool? get stringify => true;
}

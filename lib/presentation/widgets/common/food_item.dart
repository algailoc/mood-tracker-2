import 'package:flutter/material.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';

class FoodItem extends StatelessWidget {
  final FoodEntity food;
  final void Function()? onFoodPressed;
  final void Function()? onFoodLongPressed;
  final bool isSelected;

  const FoodItem({
    super.key,
    required this.food,
    this.onFoodPressed,
    this.onFoodLongPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 3,
      ),
      child: Material(
        color: isSelected
            ? Theme.of(context).colorScheme.onSecondary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          splashColor: Theme.of(context).colorScheme.primary,
          onLongPress: onFoodLongPressed,
          onTap: onFoodPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: Text(food.name),
          ),
        ),
      ),
    );
  }
}

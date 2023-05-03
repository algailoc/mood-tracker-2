import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/common/edit_activity_dialog.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class DayFoodsList extends StatefulWidget {
  final List<String> foodsIds;

  const DayFoodsList(this.foodsIds, {super.key});

  @override
  State<DayFoodsList> createState() => _DayFoodsListState();
}

class _DayFoodsListState extends State<DayFoodsList> {
  final foods = <FoodEntity>[];

  void _foodsListener(BuildContext context, FoodsState state) {
    if (state is FoodsLoadedState && state.foods.isNotEmpty) {
      setState(() {
        foods.clear();
        final allFoods = state.foods;
        for (var id in widget.foodsIds) {
          final food = allFoods.where((element) => element.id == id);
          if (food.isNotEmpty) {
            foods.add(food.first);
          }
        }
        foods.sort((a, b) => a.name.compareTo(b.name));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodsBloc, FoodsState>(
        listener: _foodsListener,
        builder: (context, state) {
          if (state.foods.isEmpty) {
            return const SizedBox();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DaySegmentTitle('foods'),
              Wrap(
                children: List.generate(
                  foods.length,
                  (index) {
                    final food = foods[index];

                    return InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      highlightColor: Colors.pink.shade100,
                      onLongPress: () async {
                        final newName = await openEditNameDialog(food.name);
                        if (newName != null && newName != food.name) {
                          if (context.mounted) {
                            BlocProvider.of<FoodsBloc>(context).add(
                              ChangeFoodNameEvent(
                                foodId: food.id,
                                newName: newName,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 3,
                        ),
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
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}

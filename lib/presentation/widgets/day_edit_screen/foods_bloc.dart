import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/helpers/confirm_delete_dialog.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/common/act_or_food_search_bar.dart';
import 'package:mood_tracker_2/presentation/widgets/common/create_activity_or_food_dialog.dart';
import 'package:mood_tracker_2/presentation/widgets/common/edit_activity_dialog.dart';
import 'package:mood_tracker_2/presentation/widgets/common/food_item.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class EditFoodsBlock extends StatefulWidget {
  const EditFoodsBlock({super.key});

  @override
  State<EditFoodsBlock> createState() => _EditFoodsBlockState();
}

class _EditFoodsBlockState extends State<EditFoodsBlock> {
  final foods = <FoodEntity>[];
  String _query = '';

  void _sortFoods() {
    foods.clear();
    var stateFoods = BlocProvider.of<FoodsBloc>(context).foods;
    if (_query.trim().isNotEmpty) {
      stateFoods = stateFoods
          .where(
            (element) => element.name
                .toLowerCase()
                .contains(_query.trim().toLowerCase()),
          )
          .toList();
    }
    foods.addAll(stateFoods);

    foods.sort((a, b) => a.name.compareTo(b.name));
  }

  void _onQueryChanged(String text) {
    setState(() {
      _query = text;
      _sortFoods();
    });
  }

  void _foodsListener(BuildContext context, FoodsState state) {
    if (state is FoodsLoadedState) {
      setState(() {
        _sortFoods();
      });
    }
  }

  void _onFoodPressed(BuildContext context, FoodEntity food) {
    final bloc = BlocProvider.of<FoodsBloc>(context);

    if (bloc.isFoodPicked(food.id)) {
      bloc.add(UnselectFoodEvent(food.id));
      BlocProvider.of<DayBloc>(context).add(RemoveFoodEvent(food));
    } else {
      bloc.add(SelectFoodEvent(food.id));
      BlocProvider.of<DayBloc>(context).add(AddFoodEvent(food));
    }
  }

  void _onFoodLongPressed(
    BuildContext context,
    FoodEntity food,
  ) async {
    final newName = await openEditNameDialog(
      food.name,
      delete: () => _deleteFood(context, food),
    );
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
  }

  void _addFood(BuildContext context) async {
    final name = await openCreateNameDialog();
    if (name != null) {
      if (context.mounted) {
        BlocProvider.of<FoodsBloc>(context).add(
          CreateFoodEvent(name),
        );
      }
    }
  }

  void _deleteFood(
    BuildContext context,
    FoodEntity food,
  ) async {
    if (await showConfirmDeleteDialog(DeleteDialogType.food)) {
      if (context.mounted) {
        BlocProvider.of<FoodsBloc>(context).add(
          DeleteFoodEvent(food.id),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodsBloc, FoodsState>(
        listener: _foodsListener,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DaySegmentTitle('foods'),
              Row(
                children: [
                  Expanded(
                    child: ActOrFoodSearchBar(onChanged: _onQueryChanged),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () => _addFood(context),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                children: List<Widget>.generate(
                  foods.length,
                  (index) {
                    final food = foods[index];

                    return FoodItem(
                      food: food,
                      isSelected: BlocProvider.of<FoodsBloc>(context)
                          .isFoodPicked(food.id),
                      onFoodLongPressed: () =>
                          _onFoodLongPressed(context, food),
                      onFoodPressed: () => _onFoodPressed(context, food),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}

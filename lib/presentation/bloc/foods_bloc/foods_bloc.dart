import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/domain/usecases/statistics_usecase.dart';

part 'foods_event.dart';
part 'foods_state.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  final StatisticsUsecase usecase;

  final foods = <FoodEntity>[];
  final _removedFoodsIds = <String>{};
  final _addedFoodsIds = <String>{};
  final _pickedFoods = <String>{};

  late final Set<String> _originalFoods;

  bool _isCreate = false;
  Mood _oldMood = Mood.mediocre;
  Mood _newMood = Mood.mediocre;

  bool isFoodPicked(String id) {
    return _pickedFoods.contains(id);
  }

  FoodsBloc(this.usecase) : super(const FoodsInitial([])) {
    on<FoodsEvent>((event, emit) async {
      if (event is InitFoodsBlocEvent) {
        emit(FoodsPendingState(foods));

        _isCreate = event.isCreate;
        _oldMood = event.originalMood;
        _newMood = _oldMood;

        foods.addAll(await usecase.getAllFoods());

        if (event.day != null) {
          _originalFoods = event.day!.foods.toSet();
          _pickedFoods.addAll(_originalFoods);
        }

        emit(FoodsLoadedState(foods));
      }

      //////////////////////////////
      // if event is save day /////
      /////////////////////////////

      else if (event is SaveDayEvent) {
        final listToUpdate = <FoodEntity>[];

        if (_oldMood != _newMood && !_isCreate) {
          final listToUpdate = _pickedFoods
              .map(
                (e) =>
                    foods.firstWhere((element) => element.id == e).changeRating(
                          oldMood: _oldMood,
                          newMood: _newMood,
                        ),
              )
              .toList();

          await usecase.updateFoodRatings(foods);

          listToUpdate.clear();
        }

        final removedFoods = foods
            .where(
              (e) => _removedFoodsIds.contains(e.id),
            )
            .toList();
        for (var food in removedFoods) {
          final newFood = food.removeRating(_newMood);
          listToUpdate.add(newFood);
        }

        final addedFoods = foods
            .where(
              (e) => _addedFoodsIds.contains(e.id),
            )
            .toList();
        for (var food in addedFoods) {
          final newFood = food.addRating(_newMood);
          listToUpdate.add(newFood);
        }

        await usecase.updateFoodRatings(foods);

        emit(FoodsLoadedState(foods));
      }

      ////////////////////////////////////
      // if event is choose food /////
      ////////////////////////////////////

      else if (event is SelectFoodEvent) {
        if (_originalFoods.contains(event.foodId)) {
          if (_removedFoodsIds.contains(event.foodId)) {
            _removedFoodsIds.remove(event.foodId);
          } else {
            _addedFoodsIds.add(event.foodId);
          }
        }

        _pickedFoods.add(event.foodId);

        emit(FoodsLoadedState(foods));
      }

      //////////////////////////////////////
      // if event is unchoose food /////
      //////////////////////////////////////

      else if (event is UnselectFoodEvent) {
        if (_originalFoods.contains(event.foodId)) {
          if (_addedFoodsIds.contains(event.foodId)) {
            _addedFoodsIds.remove(event.foodId);
          } else {
            _removedFoodsIds.add(event.foodId);
          }
        }

        _pickedFoods.remove(event.foodId);

        emit(FoodsLoadedState(foods));
      }

      //////////////////////////////////////
      // if event is update food ///////
      //////////////////////////////////////

      else if (event is ChangeFoodNameEvent) {
        final index = foods.indexWhere((element) => element.id == event.foodId);
        if (index > -1) {
          await usecase.updateFoodName(event.foodId, event.newName);
          foods[index] = foods[index].copyWith(name: event.newName);
        }

        emit(FoodsLoadedState(foods));
      }
    });
  }
}

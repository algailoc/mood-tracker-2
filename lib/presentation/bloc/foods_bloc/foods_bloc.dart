import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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

  Set<String> _originalFoods = {};

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

      else if (event is FoodsSaveDayEvent) {
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

          await usecase.updateFoodRatings(listToUpdate);

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

        await usecase.updateFoodRatings(listToUpdate);

        emit(FoodsLoadedState(foods));
      }

      ////////////////////////////////////
      // if event is choose food /////////
      ////////////////////////////////////

      else if (event is SelectFoodEvent) {
        emit(FoodsPendingState(foods));

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
      // if event is unchoose food /////////
      //////////////////////////////////////

      else if (event is UnselectFoodEvent) {
        emit(FoodsPendingState(foods));

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
      // if event is update food ///////////
      //////////////////////////////////////

      else if (event is ChangeFoodNameEvent) {
        emit(FoodsPendingState(foods));

        final index = foods.indexWhere((element) => element.id == event.foodId);
        if (index > -1) {
          await usecase.updateFoodName(event.foodId, event.newName);
          foods[index] = foods[index].copyWith(name: event.newName);
        }

        emit(FoodsLoadedState(foods));
      }

      //////////////////////////////////////
      // if event is delete food ///////////
      //////////////////////////////////////

      else if (event is DeleteFoodEvent) {
        emit(FoodsPendingState(foods));
        await usecase.deleteFood(event.id);
        final index = foods.indexWhere((element) => element.id == event.id);
        if (index != -1) {
          foods.removeAt(index);
        }

        SmartDialog.dismiss();

        emit(FoodsLoadedState(foods));
      }

      //////////////////////////////////////
      // if event is create food ///////////
      //////////////////////////////////////

      else if (event is CreateFoodEvent) {
        emit(FoodsPendingState(foods));

        final food = await usecase.addFood(event.name);
        foods.add(food);

        // Нужно также добавлять в DayBloc, но пока непонятно как это лучше сделать
        // _addedFoodsIds.add(food.id);
        // _pickedFoods.add(food.id);

        emit(FoodsLoadedState(foods));
      } else if (event is ChangeMoodForFoodsEvent) {
        emit(FoodsPendingState(foods));
        _newMood = event.newMood;
        emit(FoodsLoadedState(foods));
      }
    });
  }
}

part of 'foods_bloc.dart';

abstract class FoodsState extends Equatable {
  final List<FoodEntity> foods;

  const FoodsState(this.foods);

  @override
  List<Object> get props => [foods];
}

class FoodsInitial extends FoodsState {
  const FoodsInitial(super.foods);
}

class FoodsLoadedState extends FoodsState {
  const FoodsLoadedState(super.foods);
}

class FoodsPendingState extends FoodsState {
  const FoodsPendingState(super.foods);
}

class FoodsErrorState extends FoodsState {
  final String error;

  const FoodsErrorState(
    super.foods, {
    required this.error,
  });
}

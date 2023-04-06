part of 'foods_bloc.dart';

abstract class FoodsState extends Equatable {
  const FoodsState();
  
  @override
  List<Object> get props => [];
}

class FoodsInitial extends FoodsState {}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'foods_event.dart';
part 'foods_state.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  FoodsBloc() : super(FoodsInitial()) {
    on<FoodsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

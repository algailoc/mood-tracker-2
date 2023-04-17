import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood_tracker_2/domain/usecases/statistics_usecase.dart';

part 'foods_event.dart';
part 'foods_state.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  final StatisticsUsecase usecase;

  FoodsBloc(this.usecase) : super(FoodsInitial()) {
    on<FoodsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    // Register event handlers
    on<Increment>(_onIncrement);
    on<Decrement>(_onDecrement);
  }

  // Event handler for Increment event
  void _onIncrement(Increment event, Emitter<CounterState> emit) {
    // You can perform additional logic here if needed
    final newState = CounterState(state.counter + 1);
    emit(newState);
  }

  // Event handler for Decrement event
  void _onDecrement(Decrement event, Emitter<CounterState> emit) {
    // You can perform additional logic here if needed
    final newState = CounterState(state.counter - 1);
    emit(newState);
  }

  // Optionally, you can use mapEventToState for more complex logic
  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is Increment) {
      // You can add more complex logic here if necessary
      yield CounterState(state.counter + 1);
    } else if (event is Decrement) {
      // You can add more complex logic here if necessary
      yield CounterState(state.counter - 1);
    }
  }
}

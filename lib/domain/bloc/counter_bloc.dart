import 'dart:async';

enum CounterEvents { incrementEvent, discrementEvent }

class CounterBloc {
  int _counter = 0;

  final _inputIncrementEventController = StreamController<CounterEvents>();
  StreamSink<CounterEvents> get incrementEventSink =>
      _inputIncrementEventController.sink;
  final _outputIncrementStateController = StreamController<int>();
  Stream<int> get outputIncrementStateStream => _outputIncrementStateController.stream;

  Future<void> _changeCounterState(
    CounterEvents event,
  ) async {
    if (event == CounterEvents.incrementEvent) {
      _counter++;
    } else if (event == CounterEvents.discrementEvent) {
      _counter--;
    } else {
      throw Exception('Передается неправильный эвент');
    }
    
    _outputIncrementStateController.sink.add(_counter);
  }
  

  CounterBloc() {
    _inputIncrementEventController.stream.listen(_changeCounterState);
  }

  Future<void> dispose() async {
    _inputIncrementEventController.close();
    _outputIncrementStateController.close();
  }
}

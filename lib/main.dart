import 'package:container_bloc/domain/bloc/container_bloc.dart';
import 'package:container_bloc/domain/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Native BLoC'),
          actions: [
            LeftBtn(),
          ],
        ),
        body: BodyContent(),
      ),
    );
  }
}

class LeftBtn extends StatelessWidget {
  const LeftBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SecondPage(),
          ),
        );
      },
      icon: Icon(Icons.favorite_border_rounded),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SecondPageBodyContent(),
    );
  }
}

class SecondPageBodyContent extends StatefulWidget {
  const SecondPageBodyContent({super.key});

  @override
  State<SecondPageBodyContent> createState() => _SecondPageBodyContentState();
}

class _SecondPageBodyContentState extends State<SecondPageBodyContent> {
  CounterBloc bloc = CounterBloc();
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
          stream: bloc.outputIncrementStateStream,
          initialData: 0,
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    bloc.incrementEventSink.add(CounterEvents.incrementEvent);
                  },
                  icon: Icon(Icons.add),
                ),
                Text('${snapshot.data}'),
                IconButton(
                  onPressed: () {
                    bloc.incrementEventSink.add(CounterEvents.discrementEvent);
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            );
          }),
    );
  }
}

class BodyContent extends StatefulWidget {
  const BodyContent({super.key});

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  ContainerBloc bloc = ContainerBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(),
        Center(
          child: StreamBuilder(
              stream: bloc.outputStateStream,
              initialData: Colors.blue,
              builder: (context, snapshot) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 200,
                  height: 200,
                  color: snapshot.data,
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              heroTag: 'ads',
              backgroundColor: Colors.red,
              onPressed: () {
                bloc.inputEventSink.add(ContainerEvents.colorRedEvent);
              },
            ),
            FloatingActionButton(
              heroTag: 'fg',
              backgroundColor: Colors.green,
              onPressed: () {
                bloc.inputEventSink.add(ContainerEvents.colorGreenEvent);
              },
            ),
            FloatingActionButton(
              heroTag: 'sg',
              backgroundColor: Colors.yellow,
              onPressed: () {
                bloc.inputEventSink.add(ContainerEvents.randColorEvent);
              },
            ),
          ],
        ),
      ],
    );
  }
}

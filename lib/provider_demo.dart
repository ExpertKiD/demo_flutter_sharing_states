import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProviderDemoApp extends StatelessWidget {
  const MyProviderDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Counter(),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // either do this way
    return ChangeNotifierProvider<CounterState>(
      create: (innerContext) {
        return CounterState();
      },
      builder: (innerContext, child) {
        return child!;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Counter App with Provider'),
            centerTitle: true,
          ),
          body: const CounterViewer()),
    );
  }
}

class CounterState with ChangeNotifier {
  int counter = 0;

  void addCounter(int value) {
    counter++;
    notifyListeners();
  }

  void subtractCounter(int value) {
    counter--;
    notifyListeners();
  }

  void multiplyCounter(int value) {
    counter *= value;
    notifyListeners();
  }

  void divideCounter(int value) {
    counter = counter ~/ value;
    notifyListeners();
  }
}

class CounterViewer extends StatelessWidget {
  const CounterViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green.shade200,
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Center(
            child: Text(
              context.watch<CounterState>().counter.toString(),
              style: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Consumer<CounterState>(
          builder: (innerContext, value, child) {
            return Container(
              color: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      value.addCounter(10);
                    },
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<CounterState>(innerContext, listen: false)
                          .subtractCounter(1);
                    },
                    child: const Text('Subtract'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<CounterState>(innerContext, listen: false)
                          .multiplyCounter(3);

                      /// or
                      // context.read<CounterState>().multiplyCounter(3);
                    },
                    child: const Text('Multiply'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Provider.of<CounterState>(context, listen: false)
                      //     .divideCounter(3);
                      innerContext.read<CounterState>().divideCounter(3);
                    },
                    child: const Text('Divide'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

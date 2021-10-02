import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MyScopedModelDemoApp extends StatelessWidget {
  const MyScopedModelDemoApp({Key? key}) : super(key: key);

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
    return ScopedModel<CounterModel>(
      model: CounterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter App with Inherited Widgets'),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext innerContext) {
          return CounterViewer(
            counterModel: CounterModel.of(innerContext),
          );
        }),
      ),
    );

    // or do this way
    // return ScopedModel<CounterModel>(
    //   model: CounterModel(),
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Counter App with Inherited Widgets'),
    //       centerTitle: true,
    //     ),
    //     body: ScopedModelDescendant<CounterModel>(
    //       builder: (innerContext, child, model) {
    //         return CounterViewer(
    //           counterModel: ScopedModel.of<CounterModel>(innerContext),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}

class CounterModel extends Model {
  int counter = 0;

  static CounterModel of(BuildContext context) =>
      ScopedModel.of<CounterModel>(context, rebuildOnChange: true);

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
  final CounterModel counterModel;

  const CounterViewer({Key? key, required this.counterModel}) : super(key: key);

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
              counterModel.counter.toString(),
              style: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  counterModel.addCounter(1);
                },
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterModel.subtractCounter(1);
                },
                child: const Text('Subtract'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterModel.multiplyCounter(3);
                },
                child: const Text('Multiply'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterModel.divideCounter(3);
                },
                child: const Text('Divide'),
              ),
            ],
          ),
        )
      ],
    );
  }
}

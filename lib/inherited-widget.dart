import 'package:flutter/material.dart';

class MyInheritedWidgetDemoApp extends StatelessWidget {
  const MyInheritedWidgetDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App with Inherited Widgets'),
        centerTitle: true,
      ),
      body: MyInheritedWidget(
        counterState: this,
        child: Builder(
          builder: (BuildContext innerContext) {
            return CounterViewer(
                counterState: innerContext
                    .dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!
                    .counterState);
          },
        ),
      ),
    );
  }

  void addCounter(int value) {
    setState(() {
      counter++;
    });
  }

  void subtractCounter(int value) {
    setState(() {
      counter--;
    });
  }

  void multiplyCounter(int value) {
    setState(() {
      counter *= value;
    });
  }

  void divideCounter(int value) {
    setState(() {
      counter = (counter / value).toInt();
    });
  }
}

class MyInheritedWidget extends InheritedWidget {
  final CounterState counterState;

  const MyInheritedWidget(
      {Key? key, required Widget child, required this.counterState})
      : super(key: key, child: child);

  static MyInheritedWidget of(BuildContext context) {
    final MyInheritedWidget? widget =
        context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();

    assert(widget != null);
    return widget!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class CounterViewer extends StatelessWidget {
  final CounterState counterState;

  const CounterViewer({Key? key, required this.counterState}) : super(key: key);

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
              counterState.counter.toString(),
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
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  counterState.addCounter(1);
                },
                child: Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterState.subtractCounter(1);
                },
                child: Text('Subtract'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterState.multiplyCounter(3);
                },
                child: Text('Multiply'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterState.divideCounter(3);
                },
                child: Text('Divide'),
              ),
            ],
          ),
        )
      ],
    );
  }
}

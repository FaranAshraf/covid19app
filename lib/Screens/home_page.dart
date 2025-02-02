import 'package:covid19app/widgets/charts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Covid-19 Chart of Pakistan'),
      ),
      body: const ChartContainer(),
    );
  }
}

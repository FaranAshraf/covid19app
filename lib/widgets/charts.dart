import 'package:covid19app/API%20Functions/getcovidlist.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: getCovid19List(), // Call the async function here
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Display loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Display error if any
              } else {
                // Data is ready, use it
                List<ChartData> chartDataList = snapshot.data!
                    .map((data) => ChartData(
                        data["lastUpdatedAtApify"],
                        data["infected"] ?? 0,
                        data["recovered"] ?? 0,
                        data["deceased"] ?? 0))
                    .toList();

                return Column(
                  children: [
                    SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      series: <CartesianSeries>[
                        // Initialize line series
                        ColumnSeries<ChartData, String>(
                          color: Colors.yellow,
                          dataSource: chartDataList,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                        ),
                        ColumnSeries<ChartData, String>(
                          color: Colors.green,
                          dataSource: chartDataList,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1,
                        ),
                        ColumnSeries<ChartData, String>(
                          color: Colors.red,
                          dataSource: chartDataList,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y2,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Center(
                        child: Text('From March-2020 to Present'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Row(children: [
                            CircleAvatar(
                              backgroundColor: Colors.yellow,
                            ),
                            Text('No. of cases Report')
                          ]),
                          const Row(children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                            ),
                            Text('Recovered')
                          ]),
                          const Row(children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                            ),
                            Text('Deaths'),
                          ]),
                          Card(
                            color: Colors.lightBlue,
                            child: Text(
                                'Total No. of Deaths : ${snapshot.data![snapshot.data!.length - 1]["deceased"].toString()}'),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
    this.y1,
    this.y2,
  );
  final String x;
  final int y;
  final int y1;
  final int y2;
}

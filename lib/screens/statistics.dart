import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List day = ['day', 'week', 'month', 'Year'];
  List cat = ['expense', 'income'];
  Map<String, double> dataMap = {
    "Food": 5,
    "Rent": 3,
    "Grocery": 2,
    "Beauty": 2
  };
  int? index_color = 0;
  int? index_cat = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Statistics',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(4, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_color = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index_color == index
                                    ? Colors.teal[600]
                                    : Colors.white),
                            alignment: Alignment.center,
                            child: Text(
                              day[index],
                              style: TextStyle(
                                  color: index_color == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(2, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_cat = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index_cat == index
                                    ? Colors.teal[600]
                                    : Colors.white),
                            alignment: Alignment.center,
                            child: Text(
                              cat[index],
                              style: TextStyle(
                                  color: index_cat == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 120,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Expense',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.arrow_downward_sharp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8)))
                    ],
                  ),
                ),
                Container(
                  child: Center(
                      child: PieChart(
                    dataMap: dataMap,
                    chartRadius: MediaQuery.of(context).size.width / 1.7,
                    legendOptions: LegendOptions(
                      legendPosition: LegendPosition.bottom,
                    ),
                    chartValuesOptions:
                        ChartValuesOptions(showChartValuesInPercentage: true),
                  )),
                ),
                Text(
                  'Top Spendings',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ],
            ),
          )
        ],
      )),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pie_chart/pie_chart.dart';

class pichart extends StatefulWidget {
  const pichart({super.key});

  @override
  State<pichart> createState() => _pichartState();
}

class _pichartState extends State<pichart> {
  Map<String, double> dataMap = {
    "Food": 5,
    "Rent": 3,
    "Grocery": 2,
    "Beauty": 2
  };
  DateTime? selectedMonth;
  DateTimeRange? selectedDateRange;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                ),
              ],
            ),
            title: Text('Statistics'),
          ),
          body: TabBarView(children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(10)),
                          onPressed: () async {
                            DateTime? pickedDate = await showMonthPicker(
                                context: context,
                                initialDate: selectedMonth ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                selectedMonthBackgroundColor: Colors.teal,
                                roundedCornersRadius: 10);
                            if (pickedDate != null &&
                                pickedDate != selectedMonth) {
                              setState(() {
                                // Set the selected month to the picked month and year
                                selectedMonth = pickedDate;
                                selectedDateRange =
                                    null; // Clear the date range filter when selecting a month
                              });
                            }
                          },
                          child: Text(
                            'Select a month',
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(10),
                          ),
                          onPressed: () async {
                            DateTimeRange? pickedDateRange =
                                await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              currentDate:
                                  selectedDateRange?.start ?? DateTime.now(),
                              initialDateRange: selectedDateRange ??
                                  DateTimeRange(
                                      start: DateTime.now(),
                                      end: DateTime.now()),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor:
                                        Colors.teal, // Your primary color
                                    colorScheme: const ColorScheme.light(
                                        primary: Colors.teal),
                                    buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDateRange != null) {
                              setState(() {
                                selectedDateRange = pickedDateRange;
                                selectedMonth =
                                    null; // Clear the month filter when selecting a date range
                              });
                            }
                          },
                          child: Text(
                            'Select a date range',
                          ),
                        ),
                      ],
                    )),
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
              ],
            ),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(10)),
                          onPressed: () async {
                            DateTime? pickedDate = await showMonthPicker(
                                context: context,
                                initialDate: selectedMonth ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                selectedMonthBackgroundColor: Colors.teal,
                                roundedCornersRadius: 10);
                            if (pickedDate != null &&
                                pickedDate != selectedMonth) {
                              setState(() {
                                // Set the selected month to the picked month and year
                                selectedMonth = pickedDate;
                                selectedDateRange =
                                    null; // Clear the date range filter when selecting a month
                              });
                            }
                          },
                          child: Text(
                            'Select a month',
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(10),
                          ),
                          onPressed: () async {
                            DateTimeRange? pickedDateRange =
                                await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              currentDate:
                                  selectedDateRange?.start ?? DateTime.now(),
                              initialDateRange: selectedDateRange ??
                                  DateTimeRange(
                                      start: DateTime.now(),
                                      end: DateTime.now()),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor:
                                        Colors.teal, // Your primary color
                                    colorScheme: const ColorScheme.light(
                                        primary: Colors.teal),
                                    buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDateRange != null) {
                              setState(() {
                                selectedDateRange = pickedDateRange;
                                selectedMonth =
                                    null; // Clear the month filter when selecting a date range
                              });
                            }
                          },
                          child: Text(
                            'Select a date range',
                          ),
                        ),
                      ],
                    )),
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
              ],
            ),
          ])),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

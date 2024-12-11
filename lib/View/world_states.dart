import 'dart:async';

import 'package:covid_appdart/Models/world_states_model.dart';
import 'package:covid_appdart/Services/states_services.dart';
import 'package:covid_appdart/View/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(minutes: 15),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WorldStates())));
  }

  final colorsList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
    const Color(0xff1B5E20)
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              FutureBuilder<WorldStatesModel>(
                  future: statesServices.fetchWorldStatesrecords(),
                  builder:
                      ((context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: SpinKitWave(
                          color: Colors.blue,
                          size: 30,
                          duration: const Duration(milliseconds: 700),
                          controller: _controller,
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                          child: Text(
                        'Something went wrong',
                        style: TextStyle(fontSize: 18),
                      ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            // chartType: ChartType.ring,
                            chartRadius: MediaQuery.sizeOf(context).width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                                // showChartValuesOutside: true,
                                showChartValuesInPercentage: true),
                            colorList: colorsList,
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recover": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Death": double.parse(
                                  snapshot.data!.deaths.toString()),
                              "Active": double.parse(
                                  snapshot.data!.active.toString()),
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .03,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Card(
                              child: Column(
                                children: [
                                  ResuableRow(
                                      title: 'World Population',
                                      value:
                                          snapshot.data!.population.toString()),
                                  ResuableRow(
                                      title: 'Total Cases',
                                      value: snapshot.data!.cases.toString()),
                                  ResuableRow(
                                      title: 'Total Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ResuableRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ResuableRow(
                                      title: 'Total Death',
                                      value: snapshot.data!.deaths.toString()),
                                  ResuableRow(
                                      title: 'Today Cases',
                                      value:
                                          snapshot.data!.todayCases.toString()),
                                  ResuableRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                  ResuableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CountriesListScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: const Text(
                                  'Track Countries',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          )
                        ],
                      );
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}

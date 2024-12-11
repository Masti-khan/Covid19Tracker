import 'package:covid_appdart/View/world_states.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeath,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  CountryDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeath,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * .067),
                  child: Card(
                      child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .06,
                      ),
                      ResuableRow(
                        title: 'Cases',
                        value: widget.totalCases.toString(),
                      ),
                      ResuableRow(
                        title: 'Total Death',
                        value: widget.totalDeath.toString(),
                      ),
                      ResuableRow(
                        title: 'Total Recovered',
                        value: widget.totalRecovered.toString(),
                      ),
                      ResuableRow(
                        title: 'Active',
                        value: widget.active.toString(),
                      ),
                      ResuableRow(
                        title: 'Critical',
                        value: widget.critical.toString(),
                      ),
                      ResuableRow(
                        title: 'Today Recovered',
                        value: widget.todayRecovered.toString(),
                      ),
                      ResuableRow(
                        title: 'Tests',
                        value: widget.test.toString(),
                      )
                    ],
                  )),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

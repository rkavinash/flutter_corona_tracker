import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:humanize/humanize.dart' as humanize;

class CountryDetails extends StatefulWidget {
  final String countryId;
  CountryDetails({Key key, this.countryId}) : super(key: key);

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails>
    with TickerProviderStateMixin {
  TabController _tabController;
  Map countryData;
  fetchCountryData() async {
    http.Response response = await http.get(
        'https://disease.sh/v3/covid-19/countries/' +
            widget.countryId.toString());
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Map countryDataYesterday;
  fetchCountryDataYesterday() async {
    http.Response response = await http.get(
        'https://disease.sh/v3/covid-19/countries/' +
            widget.countryId.toString() +
            '?yesterday=true');
    setState(() {
      countryDataYesterday = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
    fetchCountryDataYesterday();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title:
            Text(countryData == null ? '' : countryData['country'] + ' Stats'),
      ),
      body: countryData == null
          ? Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: CollectionSlideTransition(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.viruses,
                        color: Theme.of(context).primaryColor),
                    FaIcon(FontAwesomeIcons.virus,
                        color: Theme.of(context).primaryColor),
                    FaIcon(FontAwesomeIcons.disease,
                        color: Theme.of(context).primaryColor),
                    FaIcon(FontAwesomeIcons.viruses,
                        color: Theme.of(context).primaryColor),
                    FaIcon(FontAwesomeIcons.viruses,
                        color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
            )
          : Container(
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            countryData['country'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Image.network(
                            countryData['countryInfo']['flag'],
                            height: 100,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: new BoxDecoration(
                            color: Theme.of(context).primaryColor),
                        child: new TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.indigoAccent[100],
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 7,
                          tabs: [
                            Tab(
                              child: Text(
                                'Today',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Yesterday',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 500,
                        child: new TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom:30),
                              child: DisplayStat(
                                data: countryData,
                                day: 'Today',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom:30),
                              child: DisplayStat(
                                data: countryDataYesterday,
                                day: 'Yesterday',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class DisplayStat extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final Map<dynamic, dynamic> data;
  final String day;
  DisplayStat({
    Key key,
    this.data,
    this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: <Widget>[
          CountryListTile(
              data: data,
              title: 'Total Cases',
              value: 'cases',
              displayIcon: FontAwesomeIcons.hospital),
          CountryListTile(
              data: data,
              title: day + ' Cases',
              value: 'todayCases',
              displayIcon: FontAwesomeIcons.hospital),
          SizedBox(
            height: 20,
          ),
          CountryListTile(
              data: data,
              title: 'Total Deaths',
              value: 'deaths',
              displayIcon: FontAwesomeIcons.skullCrossbones),
          CountryListTile(
              data: data,
              title: day + ' Deaths',
              value: 'todayDeaths',
              displayIcon: FontAwesomeIcons.skullCrossbones),
          SizedBox(
            height: 20,
          ),
          CountryListTile(
              data: data,
              title: 'Total recovered',
              value: 'recovered',
              displayIcon: FontAwesomeIcons.child),
          CountryListTile(
              data: data,
              title: day + ' Recovered',
              value: 'todayRecovered',
              displayIcon: FontAwesomeIcons.child),
          SizedBox(
            height: 20,
          ),
          CountryListTile(
              data: data,
              title: 'Current Active Cases',
              value: 'active',
              displayIcon: FontAwesomeIcons.headSideCough),
          CountryListTile(
              data: data,
              title: 'Current Critical Cases',
              value: 'critical',
              displayIcon: FontAwesomeIcons.procedures),
          CountryListTile(
              data: data,
              title: 'Total Tests Done',
              value: 'tests',
              displayIcon: FontAwesomeIcons.microscope),
          CountryListTile(
              data: data,
              title: 'Current Population',
              value: 'population',
              displayIcon: FontAwesomeIcons.users),
        ],
      ),
    );
  }
}

class CountryListTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData displayIcon;

  const CountryListTile({
    Key key,
    @required this.data,
    this.title,
    this.value,
    this.displayIcon,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: FaIcon(
        displayIcon,
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        humanize.intComma(data[value]).toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

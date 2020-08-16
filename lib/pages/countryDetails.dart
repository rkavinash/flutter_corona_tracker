import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';

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
                    FaIcon(FontAwesomeIcons.viruses),
                    FaIcon(FontAwesomeIcons.virus),
                    FaIcon(FontAwesomeIcons.disease),
                    FaIcon(FontAwesomeIcons.viruses),
                    FaIcon(FontAwesomeIcons.viruses),
                  ],
                ),
              ),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          countryData['country'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
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
                            // text: 'Today',
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
                            child: DisplayStat(
                              data: countryData,
                              day: 'Today',
                            ),
                          ),
                          Container(
                            child: DisplayStat(
                              data: countryDataYesterday,
                              day: 'Yesterday',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DisplayStat extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  final String day;
  const DisplayStat({
    Key key,
    this.data,
    this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        CountryListTile(
          data: data,
          title: 'Total Cases',
          value: 'cases',
        ),
        CountryListTile(
          data: data,
          title: day + ' Cases',
          value: 'todayCases',
        ),
        SizedBox(
          height: 20,
        ),
        CountryListTile(
          data: data,
          title: 'Total Deaths',
          value: 'deaths',
        ),
        CountryListTile(
          data: data,
          title: day + ' Deaths',
          value: 'todayDeaths',
        ),
        SizedBox(
          height: 20,
        ),
        CountryListTile(
          data: data,
          title: 'Total recovered',
          value: 'recovered',
        ),
        CountryListTile(
          data: data,
          title: day + ' Recovered',
          value: 'todayRecovered',
        ),
        SizedBox(
          height: 20,
        ),
        CountryListTile(
          data: data,
          title: 'Current Active Cases',
          value: 'active',
        ),
        CountryListTile(
          data: data,
          title: 'Current Critical Cases',
          value: 'critical',
        ),
        CountryListTile(
          data: data,
          title: 'Total Tests Done',
          value: 'tests',
        ),
        CountryListTile(
          data: data,
          title: 'Current Population',
          value: 'population',
        ),
      ],
    );
  }
}

class CountryListTile extends StatelessWidget {
  final String title;
  final String value;

  const CountryListTile({
    Key key,
    @required this.data,
    this.title,
    this.value,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      // leading: Icon(Icons.map),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        data[value].toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

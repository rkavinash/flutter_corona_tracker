import 'dart:convert';

import 'package:corona_tracker/pages/countryDetails.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';

class AllCountriesPage extends StatefulWidget {
  AllCountriesPage({Key key}) : super(key: key);

  @override
  _AllCountriesPageState createState() => _AllCountriesPageState();
}

class _AllCountriesPageState extends State<AllCountriesPage> {
  List allCountryData;
  fetchAllCountriesData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/countries?sort=cases');
    setState(() {
      allCountryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Country Stats'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: allCountryData == null
              ? Container(
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
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CountryDetails(
                                countryId: allCountryData[index]['countryInfo']
                                    ['iso2']),
                          ),
                        ),
                        child: Container(
                          height: 140,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey[500],
                            //     blurRadius: 3,
                            //   )
                            // ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (index + 1).toString() + '.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 40,
                                      child: Text(
                                        allCountryData[index]['country'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 10,
                                          )
                                        ],
                                      ),
                                      child: Image.network(
                                        allCountryData[index]['countryInfo']
                                            ['flag'],
                                        height: 60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Total Cases : ' +
                                            allCountryData[index]['cases']
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Recovered : ' +
                                            allCountryData[index]['recovered']
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Active Case : ' +
                                            allCountryData[index]['active']
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.orange[800],
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'critical Case : ' +
                                            allCountryData[index]['critical']
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Total Deaths : ' +
                                            allCountryData[index]['deaths']
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: allCountryData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
        ),
      ),
    );
  }
}

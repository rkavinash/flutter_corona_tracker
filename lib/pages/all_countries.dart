import 'dart:convert';

import 'package:corona_tracker/pages/countryDetails.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text(
          'All Country Stats',
          style: GoogleFonts.baiJamjuree(
            textStyle: Theme.of(context).textTheme.headline5,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: allCountryData == null
              ? Container(
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
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          height: 180,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              // Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 5),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         (index + 1).toString() + '.',
                              //         style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 20.0,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
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
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w900,
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
                                            blurRadius: 0.2,
                                          )
                                        ],
                                      ),
                                      child: Image.network(
                                        allCountryData[index]['countryInfo']
                                            ['flag'],
                                        height: 50,
                                        // fit: BoxFit.scaleDown,
                                        // width: 120,
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

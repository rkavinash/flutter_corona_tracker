import 'dart:convert';

import 'package:corona_tracker/pages/countryDetails.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:humanize/humanize.dart' as humanize;

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
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text(
                                      (index + 1).toString() +
                                          '. ' +
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
                                ),
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5,
                                          )
                                        ],
                                      ),
                                  child: Image.network(
                                    allCountryData[index]['countryInfo']
                                        ['flag'],
                                    fit: BoxFit.fitHeight,
                                    height: 100,
                                  ),
                                ),
                              ),
                              Card(
                                child: _DisplayListItem(
                                  allCountryData: allCountryData,
                                  caseName: 'cases',
                                  listColor: Colors.redAccent[700],
                                  listHeading: 'Total Cases : ',
                                  i: index,
                                  displayIcon: FontAwesomeIcons.hospitalAlt,
                                ),
                              ),
                              Card(
                                child: _DisplayListItem(
                                  allCountryData: allCountryData,
                                  caseName: 'active',
                                  listColor: Colors.amber[900],
                                  listHeading: 'Active Cases : ',
                                  i: index,
                                  displayIcon: FontAwesomeIcons.procedures,
                                ),
                              ),
                              Card(
                                child: _DisplayListItem(
                                  allCountryData: allCountryData,
                                  caseName: 'deaths',
                                  listColor: Colors.black,
                                  listHeading: 'Total Deaths : ',
                                  i: index,
                                  displayIcon: FontAwesomeIcons.skullCrossbones,
                                ),
                              ),
                              Card(
                                  child: Container(
                                alignment: Alignment.bottomRight,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CountryDetails(
                                            countryId: allCountryData[index]
                                                ['countryInfo']['iso2']),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'view more >',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              )),
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

class _DisplayListItem extends StatelessWidget {
  final String listHeading;
  final String caseName;
  final Color listColor;
  final int i;
  final IconData displayIcon;

  const _DisplayListItem({
    Key key,
    @required this.allCountryData,
    this.listHeading,
    this.caseName,
    this.listColor,
    this.i,
    this.displayIcon,
  }) : super(key: key);

  final List allCountryData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        displayIcon,
        size: 40,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        listHeading + humanize.intComma(allCountryData[i][caseName]).toString(),
        style: TextStyle(
          color: listColor,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

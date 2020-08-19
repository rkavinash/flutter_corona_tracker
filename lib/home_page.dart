import 'dart:convert';

import 'package:corona_tracker/data/datasource.dart';
import 'package:corona_tracker/pages/all_countries.dart';
import 'package:corona_tracker/panels/continent_data.dart';
import 'package:corona_tracker/panels/info_panel.dart';
import 'package:corona_tracker/panels/mostAffectedCountry_panel.dart';
import 'package:corona_tracker/panels/vaccine_panel.dart';
import 'package:corona_tracker/panels/worldwide_panel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldData() async {
    http.Response response = await http.get(
        'https://disease.sh/v3/covid-19/all?yesterday=false&allowNull=true');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List mostAffectedCountriesData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/countries?sort=cases');
    setState(() {
      mostAffectedCountriesData = json.decode(response.body);
    });
  }

  List continentData;
  fetchContinentData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/continents?sort=cases');
    setState(() {
      continentData = json.decode(response.body);
    });
  }

  Map vaccineData;
  fetchVaccineData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/vaccine');
    setState(() {
      vaccineData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWorldData();
    fetchCountryData();
    fetchContinentData();
    fetchVaccineData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Covid-19 Tracker'.toUpperCase(),
          style: GoogleFonts.baiJamjuree(
            textStyle: Theme.of(context).textTheme.headline5,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: worldData == null
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
            : Column(
                children: <Widget>[
                  QuotePanel(),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shadowColor: Theme.of(context).primaryColor,
                    elevation: 6,
                    child: Column(
                      children: [
                        WorldwidePanelHeading(),
                        Divider(thickness: 2,),
                        worldData == null
                            ? Container()
                            : WorldwidePanel(
                                worlwidedata: worldData,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shadowColor: Theme.of(context).primaryColor,
                    elevation: 6,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MostAffectedCountriesPanelHeading(),
                        Divider(thickness: 2,),
                        mostAffectedCountriesData == null
                            ? Container()
                            : MostAffectedCountriesPanel(
                                countryData: mostAffectedCountriesData,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shadowColor: Theme.of(context).primaryColor,
                    elevation: 6,
                    borderOnForeground: true,
                    child: Column(
                      children: [
                        ContinentPanelHeading(),
                        Divider(
                          thickness: 2,
                        ),
                        continentData == null
                            ? Container()
                            : ContinentDataPanel(
                                continentData: continentData,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shadowColor: Theme.of(context).primaryColor,
                    elevation: 6,
                    child: Column(
                      children: [
                        VaccinePanelHeading(),
                        Divider(thickness: 2,),
                        vaccineData == null
                            ? Container(
                                child: Text('null'),
                              )
                            : VaccinePanel(
                                vaccineData: vaccineData,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InfoPanel(),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'We are together in the fight'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
      ),
    );
  }
}

class ContinentPanelHeading extends StatelessWidget {
  const ContinentPanelHeading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Continents Count'.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class VaccinePanelHeading extends StatelessWidget {
  const VaccinePanelHeading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Vaccine Status'.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MostAffectedCountriesPanelHeading extends StatelessWidget {
  const MostAffectedCountriesPanelHeading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Most Affected Countries'.toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllCountriesPage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'View All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WorldwidePanelHeading extends StatelessWidget {
  const WorldwidePanelHeading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: Text(
        'Worldwide'.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class QuotePanel extends StatelessWidget {
  const QuotePanel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).primaryColor,
      elevation: 6,
      borderOnForeground: true,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: 100,
        color: Colors.deepPurple[400],
        child: Text(
          DataSource.quote,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

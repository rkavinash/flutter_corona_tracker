import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class VaccineDetails extends StatelessWidget {
  final Map vaccineData;
  final String phase;
  const VaccineDetails({Key key, this.vaccineData, this.phase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _vaccineDetails = vaccineData['data'];
    List _filteredVaccine =
        _vaccineDetails.where((i) => i['trialPhase'] == phase).toList();

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text(
          '$phase - Vaccine',
          style: GoogleFonts.baiJamjuree(
            textStyle: Theme.of(context).textTheme.headline5,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Card(
              elevation: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: FaIcon(
                      FontAwesomeIcons.syringe,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    title: Text(
                      _filteredVaccine[index]['candidate'],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(thickness: 2,),
                        SizedBox(
                          height: 20,
                        ),
                        VaccineHeadingText(
                          title: 'Instututions involved:',
                        ),
                        VaccineDetailsList(
                          filteredVaccine: _filteredVaccine,
                          mainIndex: index,
                          subDetail: 'institutions',
                        ),
                        Divider(thickness: 2,),
                        SizedBox(
                          height: 20,
                        ),
                        VaccineHeadingText(
                          title: 'funding:',
                        ),
                        VaccineDetailsList(
                          filteredVaccine: _filteredVaccine,
                          mainIndex: index,
                          subDetail: 'funding',
                        ),
                        Divider(thickness: 2,),
                        SizedBox(
                          height: 20,
                        ),
                        VaccineHeadingText(
                          title: 'Sponsors:',
                        ),
                        VaccineDetailsList(
                          filteredVaccine: _filteredVaccine,
                          mainIndex: index,
                          subDetail: 'sponsors',
                        ),
                        Divider(thickness: 2,),
                        SizedBox(
                          height: 20,
                        ),
                        VaccineHeadingText(
                          title: 'Details:',
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ReadMoreText(
                            _filteredVaccine[index]['details'],
                            trimLines: 3,
                            colorClickableText: Theme.of(context).primaryColor,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '...Show more',
                            trimExpandedText: ' show less',
                            style: TextStyle(
                              color: Colors.blueAccent[700],
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _filteredVaccine.length,
        shrinkWrap: true,
      ),
    );
  }
}

class VaccineDetailsList extends StatelessWidget {
  final int mainIndex;
  final String subDetail;
  const VaccineDetailsList({
    Key key,
    @required List filteredVaccine,
    this.mainIndex,
    this.subDetail,
  })  : _filteredVaccine = filteredVaccine,
        super(key: key);

  final List _filteredVaccine;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return _filteredVaccine[mainIndex][subDetail][i].length == 0
            ? Text('---')
            : Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  (i + 1).toString() +
                      '.' +
                      _filteredVaccine[mainIndex][subDetail][i],
                  style: TextStyle(
                    color: Colors.blueAccent[700],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
      },
      itemCount: _filteredVaccine[mainIndex][subDetail].length,
      shrinkWrap: true,
    );
  }
}

class VaccineHeadingText extends StatelessWidget {
  final String title;

  const VaccineHeadingText({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: Colors.indigoAccent[700],
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

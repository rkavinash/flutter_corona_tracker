import 'package:corona_tracker/pages/vaccine_details_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VaccinePanel extends StatelessWidget {
  final Map vaccineData;
  const VaccinePanel({Key key, this.vaccineData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List phases = vaccineData['phases'];

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            child: Card(
              margin: EdgeInsets.symmetric(vertical:5),
              elevation: 3,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VaccineDetails(
                        vaccineData: vaccineData,
                        phase: phases[index]['phase']),
                  ),
                ),
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.shieldVirus,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    phases[index]['phase'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'No of Candidates: ${phases[index]["candidates"]}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: phases.length,
        shrinkWrap: true,
      ),
    );
  }
}

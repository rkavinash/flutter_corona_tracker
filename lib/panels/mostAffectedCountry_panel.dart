import 'package:flutter/material.dart';
import 'package:humanize/humanize.dart' as humanize;

class MostAffectedCountriesPanel extends StatelessWidget {
  final List countryData;

  const MostAffectedCountriesPanel({Key key, this.countryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Text(
                  humanize.ordinal((index + 1)).toString() + '.',
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Image.network(
                  countryData[index]['countryInfo']['flag'],
                  height: 30,
                ),
                SizedBox(width: 10),
                Text(
                  countryData[index]['country'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(width: 20),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[700],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Cases: ' + humanize.intComma(countryData[index]['cases']).toString(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

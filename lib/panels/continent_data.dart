import 'package:flutter/material.dart';
import 'package:humanize/humanize.dart' as humanize;

class ContinentDataPanel extends StatelessWidget {
  final List continentData;

  const ContinentDataPanel({Key key, this.continentData}) : super(key: key);

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
                    color: Colors.blueGrey[700],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  continentData[index]['continent'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                        'Cases: ' + humanize.intComma(continentData[index]['cases']).toString(),
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

import 'package:flutter/material.dart';

class MostAffectedCountriesPanel extends StatelessWidget {
  final List countryData;

  const MostAffectedCountriesPanel({Key key, this.countryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  (index + 1).toString() + '.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width:5),
                Image.network(
                  countryData[index]['countryInfo']['flag'],
                  height: 30,
                ),
                SizedBox(width:10),
                Text(
                  countryData[index]['country'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width:20),
                Text(
                  'Cases: ' + countryData[index]['cases'].toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
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

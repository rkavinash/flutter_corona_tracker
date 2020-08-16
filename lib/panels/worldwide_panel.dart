import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {

  final Map worlwidedata;
  const WorldwidePanel({Key key, this.worlwidedata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: [
          StatusPanel(panelColor: Colors.redAccent[400], textColor: Colors.white, title: 'confirmed', count: worlwidedata['cases'].toString(),),
          StatusPanel(panelColor: Colors.blueAccent[400], textColor: Colors.white, title: 'active', count: worlwidedata['active'].toString(),),
          StatusPanel(panelColor: Colors.green[900], textColor: Colors.white, title: 'recovered', count: worlwidedata['recovered'].toString(),),
          StatusPanel(panelColor: Colors.blueGrey[900], textColor: Colors.white, title: 'deaths', count: worlwidedata['deaths'].toString(),),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 80,
      width: width / 2,
      color: panelColor,
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              color: textColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_covid19_rest_api/app/services/api.dart';
import 'package:intl/intl.dart';

class EndPointCardData {
  EndPointCardData({this.title, this.assetName, this.color});
  final String title;
  final String assetName;
  final Color color;
}

class EndPointCard extends StatelessWidget {
  const EndPointCard({
    Key key,
    this.endPoint,
    this.value,
  }) : super(key: key);

  final EndPoint endPoint;
  final int value;

  static Map<EndPoint, EndPointCardData> _cardsData = {
    EndPoint.cases: EndPointCardData(
      title: 'Cases',
      assetName: 'assets/count.png',
      color: Color(0xFFFFF492),
    ),
    EndPoint.casesSuspected: EndPointCardData(
      title: 'Suspected cases',
      assetName: 'assets/suspect.png',
      color: Color(0xFFEEDA28),
    ),
    EndPoint.casesConfirmed: EndPointCardData(
      title: 'Confirmed cases',
      assetName: 'assets/fever.png',
      color: Color(0xFFE99600),
    ),
    EndPoint.deaths: EndPointCardData(
      title: 'Deaths',
      assetName: 'assets/death.png',
      color: Color(0xFFE40000),
    ),
    EndPoint.recovered: EndPointCardData(
      title: 'Recovered',
      assetName: 'assets/patient.png',
      color: Color(0xFF70A901),
    ),
  };

  String get formattedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('##,##,##,##,##,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endPoint];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color),
              ),
              SizedBox(
                height: 4.0,
              ),
              SizedBox(
                height: 52.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      cardData.assetName,
                      color: cardData.color,
                    ),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: cardData.color,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

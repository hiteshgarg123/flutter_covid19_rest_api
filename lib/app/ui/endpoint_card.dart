import 'package:flutter/material.dart';
import 'package:flutter_covid19_rest_api/app/services/api.dart';

class EndPointCard extends StatelessWidget {
  const EndPointCard({
    Key key,
    this.endPoint,
    this.value,
  }) : super(key: key);

  final EndPoint endPoint;
  final int value;

  @override
  Widget build(BuildContext context) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Cases',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

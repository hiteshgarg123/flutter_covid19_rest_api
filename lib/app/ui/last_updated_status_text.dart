import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormatter {
  LastUpdatedDateFormatter({@required this.lastUpdates});
  final DateTime lastUpdates;

  String lastUpdatesStatusText() {
    if (lastUpdates != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdates);
      return 'Last updated: $formatted';
    }
    return '';
  }
}

class LastUpdatesStatusText extends StatelessWidget {
  const LastUpdatesStatusText({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

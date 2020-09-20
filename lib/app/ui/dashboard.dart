import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_covid19_rest_api/app/repositories/data_repository.dart';
import 'package:flutter_covid19_rest_api/app/repositories/endpoints_data.dart';
import 'package:flutter_covid19_rest_api/app/services/api.dart';
import 'package:flutter_covid19_rest_api/app/ui/endpoint_card.dart';
import 'package:flutter_covid19_rest_api/app/ui/last_updated_status_text.dart';
import 'package:flutter_covid19_rest_api/app/ui/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndPointsData _endPointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endPointsData = dataRepository.getAllEndPointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endPointsData = await dataRepository.getAllEndPointData();
      setState(() => _endPointsData = endPointsData);
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'Ok',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Unknown error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'Ok',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdates: _endPointsData != null
          ? _endPointsData.values[EndPoint.cases]?.date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coronavirus Tracker',
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            LastUpdatesStatusText(
              text: formatter.lastUpdatesStatusText(),
            ),
            for (var endPoint in EndPoint.values)
              EndPointCard(
                endPoint: endPoint,
                value: _endPointsData != null
                    ? _endPointsData.values[endPoint]?.value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}

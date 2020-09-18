import 'package:flutter/material.dart';
import 'package:flutter_covid19_rest_api/app/repositories/data_repository.dart';
import 'package:flutter_covid19_rest_api/app/repositories/endpoints_data.dart';
import 'package:flutter_covid19_rest_api/app/services/api.dart';
import 'package:flutter_covid19_rest_api/app/ui/endpoint_card.dart';
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
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endPointsData = await dataRepository.getAllEndPointData();
    setState(() => _endPointsData = endPointsData);
  }

  @override
  Widget build(BuildContext context) {
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
            for (var endPoint in EndPoint.values)
              EndPointCard(
                endPoint: endPoint,
                value: _endPointsData != null
                    ? _endPointsData.values[endPoint]
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_covid19_rest_api/app/repositories/data_repository.dart';
import 'package:flutter_covid19_rest_api/app/services/api.dart';
import 'package:flutter_covid19_rest_api/app/ui/endpoint_card.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _cases;

  @override
  void initState() {
    super.initState();
    _updateData();
  }
  
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndPointData(EndPoint.cases);
    setState(() => _cases = cases);
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
      body: ListView(
        children: <Widget>[
          EndPointCard(
            endPoint: EndPoint.cases,
            value: _cases,
          ),
        ],
      ),
    );
  }
}

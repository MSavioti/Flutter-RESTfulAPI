import 'package:EstudoRESTfulAPI/app/repositories/data_repository.dart';
import 'package:EstudoRESTfulAPI/app/repositories/endpoints_data.dart';
import 'package:EstudoRESTfulAPI/app/services/api.dart';
import 'package:EstudoRESTfulAPI/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndPointsData _endPointsData;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endPointsData = await dataRepository.getAllEndPoints();
    setState(() => _endPointsData = endPointsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
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

import 'dart:io';

import 'package:EstudoRESTfulAPI/app/repositories/data_repository.dart';
import 'package:EstudoRESTfulAPI/app/repositories/endpoints_data.dart';
import 'package:EstudoRESTfulAPI/app/services/api.dart';
import 'package:EstudoRESTfulAPI/app/ui/endpoint_card.dart';
import 'package:EstudoRESTfulAPI/app/ui/last_updated_status_text.dart';
import 'package:EstudoRESTfulAPI/app/ui/show_alert_dialog.dart';
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
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endPointsData = dataRepository.getAllEndPointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endPointsData = await dataRepository.getAllEndPointsData();
      setState(() => _endPointsData = endPointsData);
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Erro de conexão',
        content:
            'Não foi possível recuperar os dados. Verifique sua conexão ou tente novamente mais tarde.',
        defaultActionText: 'Continuar',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Erro desconhecido',
        content:
            'Entre em contato com o suporte ou tente novamente mais tarde.',
        defaultActionText: 'Continuar',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdated: _endPointsData != null
          ? _endPointsData.values[EndPoint.cases]?.date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
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

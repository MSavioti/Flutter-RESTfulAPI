import 'package:EstudoRESTfulAPI/app/repositories/data_repository.dart';
import 'package:EstudoRESTfulAPI/app/services/api.dart';
import 'package:EstudoRESTfulAPI/app/services/api_service.dart';
import 'package:EstudoRESTfulAPI/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: ApiService(API.sandbox())),
      child: MaterialApp(
        title: 'Coronavirus Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}

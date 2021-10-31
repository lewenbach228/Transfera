import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/flooz_data.dart';
import './providers/tmoney_data.dart';
import './routes.dart';
import '../screens/tab_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FloozData(),
        ),
        ChangeNotifierProvider(
          create: (context) => TmoneyData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Transfert d'Argent",
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: TabScreen(),
        routes: routes,
      ),
    );
  }
}

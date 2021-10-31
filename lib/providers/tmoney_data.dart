import 'package:flutter/widgets.dart';

class TmoneyModel with ChangeNotifier {
  final String id;
  final int somme;
  final String numero;
  TmoneyModel({
    required this.id,
    required this.somme,
    required this.numero,
  });
}

class TmoneyData with ChangeNotifier {
  List<TmoneyModel> _tmoneydata = [
    // TmoneyModel(
    //   id: '1',
    //   somme: 2500,
    //   numero: "97413256",
    // ),
    // TmoneyModel(
    //   id: '2',
    //   somme: 1000,
    //   numero: "91072096",
    // ),
    // TmoneyModel(
    //   id: '3',
    //   somme: 1500,
    //   numero: "99850330",
    // ),
    // TmoneyModel(
    //   id: '4',
    //   somme: 4500,
    //   numero: "99413256",
    // ),
    // TmoneyModel(
    //   id: '5',
    //   somme: 500,
    //   numero: "90045630",
    // ),
  ];
  List<TmoneyModel> get tmoneyData {
    return [..._tmoneydata];
  }
}

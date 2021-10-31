import 'package:flutter/widgets.dart';
// import 'package:transfert_argent/helpers/db_helpers.dart';

class FloozModel with ChangeNotifier {
  final dynamic id;
  final int somme;
  final String numero;
  final typeOfTrans;

  FloozModel({
    required this.id,
    required this.somme,
    required this.numero,
    this.typeOfTrans,
  });
}

class FloozData with ChangeNotifier {
  List<FloozModel> _floozdata = [
    // FloozModel(
    //   id: 'a',
    //   somme: 2500,
    //   numero: "97413256",
    // ),
  ];
  List<FloozModel> get floozData {
    return [..._floozdata];
  }

  //  Total des operations dépôt
  int get totalAmountDepot {
    var total = 0;
    final depotList = _floozdata.where(
      (e) => e.typeOfTrans.contains('Dépôt'),
    );
    depotList.forEach((floozItem) {
      total += floozItem.somme;
    });
    return total;
  }

//  Total des operations retrait
  int get totalAmountRetrait {
    var total = 0;
    final retraitList = _floozdata.where(
      (e) => e.typeOfTrans.contains('Retrait'),
    );
    retraitList.forEach((floozItem) {
      total += floozItem.somme;
    });
    return total;
  }

  void addNewTrans(FloozModel newTrans) {
    final addTrans = FloozModel(
      id: DateTime.now().toString(),
      somme: newTrans.somme,
      numero: newTrans.numero,
      typeOfTrans: newTrans.typeOfTrans,
    );
    // _floozdata.add(addTrans);
    _floozdata.insert(0, addTrans);

    notifyListeners();
    // DBHelper.insert('floozOperation', {
    //   'id': newTrans.id,
    //   'somme': newTrans.somme,
    //   'numero': newTrans.numero,
    //   'typeOfTrans': newTrans.typeOfTrans,
    // });
  }

  // Supprimer une Girl dans l'historique
  void supprimerGirl(String floozId) {
    _floozdata.removeWhere((e) => e.id == floozId);
    notifyListeners();
  }

  //  RECUPERE LES DONNEES DANS LA BASE LOCAL
  // Future<void> fetchAndSetPlaces() async {
  //   final dataList = await DBHelper.getData('floozOperation');
  //   _floozdata = dataList
  //       .map(
  //         (item) => FloozModel(
  //           id: item['id'],
  //           somme: item['somme'],
  //           numero: item['numero'],
  //           typeOfTrans: item['typeOfTrans'],
  //         ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

  // Modifier une Girl grace au Formulaire
  void editExistingTrans(String id, FloozModel newTrans) {
    final floozIndex = _floozdata.indexWhere((element) => element.id == id);
    if (floozIndex >= 0) {
      _floozdata[floozIndex] = newTrans;
      notifyListeners();
    } else {
      print('TransIndex < 0');
    }
  }
}

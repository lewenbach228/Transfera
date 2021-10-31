import 'package:flutter/material.dart';
import 'package:transfert_argent/screens/add_flooz_trans.dart';

import '../providers/flooz_data.dart';
import '../widgets/flooz_item.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:transition/transition.dart';

class Flooz extends StatefulWidget {
  static const routeName = '/Flooz';

  @override
  _FloozState createState() => _FloozState();
}

class _FloozState extends State<Flooz> {
  List<FloozModel> filterList = [];
  dynamic virtuelController = new TextEditingController();
  dynamic cashController = new TextEditingController();
  final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cashController.text = '0';
    virtuelController.text = '0';
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (int.parse(cashController.text) > 0 ||
          int.parse(virtuelController.text) > 0) {
        return;
      } else
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => new AlertDialog(
            title: new Container(
              height: 60,
              width: double.infinity,
              child: Image.asset(
                'assets/images/moov.png',
                fit: BoxFit.contain,
              ),
              // alignment: Alignment.center,
            ),
            content: new Stack(
              //clipBehavior: Clip.visible,
              children: <Widget>[
                Form(
                  key: _keyDialogForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Entrer le Cash flooz',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le cash flooz';
                            }
                            if (int.parse(value) <= 0) {
                              return 'Veuillez saisir une somme supérieur à zéro';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Veuillez saisir une somme valide';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            cashController.text = val;
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Entrer le Virtuel flooz',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le virtuel flooz';
                            }
                            if (int.parse(value) <= 0) {
                              return 'Veuillez saisir une somme valide';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Veuillez saisir une somme valide';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            virtuelController.text = val;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new ElevatedButton(
                child: new Text("Enregistrer"),
                onPressed: () {
                  if (_keyDialogForm.currentState!.validate()) {
                    _keyDialogForm.currentState!.save();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      filterList = Provider.of<FloozData>(context).floozData;
    });
    super.didChangeDependencies();
  }

  Widget operationRow(
      String type, String total, Color color, Color backgroundColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          type,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Chip(
          label: Text(
            total,
            style: TextStyle(
              color: color,
              fontSize: 15,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }

  Widget transitionIcon(
      {required TransitionEffect transitionEffect, required IconData icon}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            Transition(
                child: AddFloozTrans(), transitionEffect: transitionEffect));
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  final options = LiveOptions(
    // Start animation after (default zero)
    // delay: Duration(milliseconds: 500),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 150),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 300),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final floozi = Provider.of<FloozData>(context, listen: false);
    final flooz = floozi.floozData;
    var cash = int.parse(cashController.text);
    var virtuel = int.parse(virtuelController.text);

    cash = cash + floozi.totalAmountDepot - floozi.totalAmountRetrait;
    virtuel = virtuel - floozi.totalAmountDepot + floozi.totalAmountRetrait;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .50,
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Filtrer',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          PopupMenuButton(
                            elevation: 4,
                            padding: EdgeInsets.all(6),
                            icon: Icon(
                              Icons.tune_rounded,
                              color: Colors.white,
                            ),
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                child: GestureDetector(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 4),
                                      Text('Filtrer par '),
                                    ],
                                  ),
                                ),
                                value: 0,
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      filterList = flooz;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.all_out,
                                      ),
                                      SizedBox(width: 6),
                                      Text('Tous'),
                                    ],
                                  ),
                                ),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      filterList = flooz
                                          .where(
                                            (e) =>
                                                e.typeOfTrans.contains('Dépôt'),
                                          )
                                          .toList();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.money,
                                      ),
                                      SizedBox(width: 6),
                                      Text('Dépôt'),
                                    ],
                                  ),
                                ),
                                value: 3,
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      filterList = flooz
                                          .where(
                                            (e) => e.typeOfTrans
                                                .contains('Retrait'),
                                          )
                                          .toList();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on,
                                      ),
                                      SizedBox(width: 6),
                                      Text('Retrait'),
                                    ],
                                  ),
                                ),
                                value: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Flooz Money",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    height: size.height * .32,
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          operationRow(
                            "Cash : ",
                            '$cash FCFA',
                            Colors.white,
                            Colors.deepOrange,
                          ),
                          operationRow(
                            'Dépôt :',
                            '${floozi.totalAmountDepot} FCFA',
                            Colors.white,
                            Colors.blue,
                          ),
                          operationRow(
                            'Virtuel : ',
                            '$virtuel FCFA',
                            Colors.white,
                            Colors.deepOrange,
                          ),
                          operationRow(
                            'Retrait : ',
                            '${floozi.totalAmountRetrait} FCFA',
                            Colors.white,
                            Colors.lightGreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                  flooz.isEmpty
                      ? Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Aucune opération disponible!',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      :
                      // FutureBuilder(
                      //     future: Provider.of<FloozData>(context, listen: false)
                      //         .fetchAndSetPlaces(),
                      //     builder: (ctx, snapshot) => snapshot
                      //                 .connectionState ==
                      //             ConnectionState.waiting
                      //         ? Center(
                      //             child: CircularProgressIndicator(
                      //               color: Colors.blue,
                      //             ),
                      //           )
                      //         :
                      Consumer<FloozData>(
                          builder: (ctx, floozTrans, _) => Expanded(
                            child: LiveList.options(
                              options: options,
                              itemBuilder: (
                                BuildContext context,
                                int i,
                                Animation<double> animation,
                              ) =>
                                  FadeTransition(
                                opacity: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ).animate(animation),
                                // And slide transition
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(0, -0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  // Paste you Widget
                                  child: ChangeNotifierProvider.value(
                                    value: filterList[i],
                                    child: FloozItem(),
                                  ),
                                ),
                              ),
                              itemCount: filterList.length,
                              scrollDirection: Axis.vertical,
                            ),
                          ),
                        ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      //  Sert aussi à incrementer le panier
      floatingActionButton: transitionIcon(
        transitionEffect: TransitionEffect.SCALE,
        icon: Icons.add,
      ),
    );
  }
}

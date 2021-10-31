import 'package:flutter/material.dart';

import '../providers/tmoney_data.dart';
import '../widgets/Tmoney_item.dart';
import 'package:provider/provider.dart';

class Tmoney extends StatefulWidget {
  static const routeName = '/Tmoney';

  @override
  _TmoneyState createState() => _TmoneyState();
}

class _TmoneyState extends State<Tmoney> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final tmoneyzi = Provider.of<TmoneyData>(context);
    final tmoney = tmoneyzi.tmoneyData;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.nature_people,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "TMoney",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: tmoney[i],
                        child: tmoney.isEmpty
                            ? Center(
                                child: Text(
                                  'Aucune opération disponible!',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : TmoneyItem(),
                      ),
                      itemCount: tmoney.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

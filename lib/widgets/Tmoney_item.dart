import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/tmoney_data.dart';

class TmoneyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tmoney = Provider.of<TmoneyModel>(context);

    return Card(
      child: new ListTile(
        title: Text(
          tmoney.somme.toString(),
          style: TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          tmoney.somme.toString(),
          style: TextStyle(fontSize: 16),
        ),
        // trailing: ,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_argent/screens/add_flooz_trans.dart';
import '../providers/flooz_data.dart';

class FloozItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final floozi = Provider.of<FloozModel>(context);
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Etes vous sûr ?',
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: primaryColor,
              // ),
            ),
            content: Text(
              'Voulez-vous vraiment supprimer cet opération ?',
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text('Oui')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('Annuler'))
            ],
          ),
        );
      },
      //  Sert aussi à decrementer le panier
      onDismissed: (direction) {
        Provider.of<FloozData>(context, listen: false).supprimerGirl(floozi.id);
      },
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              AddFloozTrans.routeName,
              arguments: floozi.id,
            );
          },
          child: Container(
            child: new ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/moov.png',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                floozi.somme.toString(),
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                floozi.numero,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              trailing: Text(
                floozi.typeOfTrans,
                style: TextStyle(
                  fontSize: 16,
                  color: floozi.typeOfTrans.contains('Dépôt')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

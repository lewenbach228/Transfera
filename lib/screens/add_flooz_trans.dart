import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flooz_data.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddFloozTrans extends StatefulWidget {
  static const routeName = '/flooz_trans';

  @override
  _AddFloozTransState createState() => _AddFloozTransState();
}

class _AddFloozTransState extends State<AddFloozTrans> {
  FocusNode numeroFocusNode = FocusNode();

  static final GlobalKey<FormBuilderState> _form =
      GlobalKey<FormBuilderState>();
  var initValue = {
    'somme': '',
    'numéro': '',
    'typeOfTrans': '',
  };
  var _editTrans = FloozModel(
    id: null,
    somme: 0,
    numero: '',
    typeOfTrans: '',
  );

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    numeroFocusNode.dispose();

    super.dispose();
  }

  // Modifier Operation
  var _init = true;
  @override
  void didChangeDependencies() {
    if (_init) {
      final floozEditId = ModalRoute.of(context)!.settings.arguments as dynamic;
      if (floozEditId != null) {
        _editTrans = (Provider.of<FloozData>(context, listen: false)
            .floozData
            .firstWhere((flooz) => flooz.id == floozEditId));
        initValue = {
          'somme': _editTrans.somme.toString(),
          'numero': _editTrans.numero,
          'typeOfTrans': _editTrans.typeOfTrans,
        };
      }
    } else {
      _init = false;
    }
    super.didChangeDependencies();
  }

  // Sauvegarde et Ajout Operation
  void _saveAjouterTrans() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    // setState(() {
    //   _isLoading = true;
    // });
    if (_editTrans.id != null) {
      Provider.of<FloozData>(context, listen: false)
          .editExistingTrans(_editTrans.id, _editTrans);
      // setState(() {
      //   _isLoading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La transaction a bien été modifié !'),
          duration: Duration(milliseconds: 1500),
        ),
      );
    } else {
      Provider.of<FloozData>(context, listen: false).addNewTrans(_editTrans);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text(
          'Transfert FLOOZ',
          style: TextStyle(
              // color: primaryColor,
              ),
        ),
        // backgroundColor: iconColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/moov.png',
                      fit: BoxFit.contain,
                    ),
                    // alignment: Alignment.center,
                  ),
                ),
                FormBuilder(
                  key: _form,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'somme',
                        initialValue: initValue['somme'],
                        decoration:
                            InputDecoration(labelText: 'Entrer la somme'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) {
                          FocusScope.of(context).requestFocus(numeroFocusNode);
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.numeric(context,
                              errorText: 'Veuillez saisir une somme valide.'),
                          FormBuilderValidators.required(context,
                              errorText:
                                  'Veuillez saisir la somme de transfert.'),
                          FormBuilderValidators.integer(context,
                              errorText:
                                  'La somme saisie doit être un entier.'),
                          (value) {
                            if (int.parse(value!) <= 0)
                              return 'La somme saisie ne doit pas être negative.';
                            return null;
                          }
                        ]),
                        onSaved: (value) {
                          _editTrans = FloozModel(
                            id: _editTrans.id,
                            somme: int.parse(
                              value.toString(),
                            ),
                            numero: _editTrans.numero,
                            typeOfTrans: _editTrans.typeOfTrans,
                          );
                        },
                      ),
                      FormBuilderTextField(
                        focusNode: numeroFocusNode,
                        name: 'numero',
                        initialValue: initValue['numero'],
                        decoration:
                            InputDecoration(labelText: 'Numéro de Téléphone '),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.numeric(context,
                              errorText: 'Veuillez saisir un nnuméro valide.'),
                          FormBuilderValidators.required(context,
                              errorText:
                                  'Veuillez saisir le numéro de transfert.'),
                          FormBuilderValidators.integer(context,
                              errorText: 'Veuillez saisir un numéro valide.'),
                          (value) {
                            if (value!.length != 8)
                              return 'Veuillez un numéro à 8 chiffres';
                            return null;
                          }
                        ]),
                        onSaved: (value) {
                          _editTrans = FloozModel(
                            id: _editTrans.id,
                            somme: _editTrans.somme,
                            numero: value.toString(),
                            typeOfTrans: _editTrans.typeOfTrans,
                          );
                        },
                      ),
                      FormBuilderRadioGroup(
                        initialValue: initValue['typeOfTrans'],
                        name: 'typeOperation',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText:
                                  'Veuillez choisir le type de transfert.'),
                        ]),
                        options: [
                          "Dépôt",
                          "Retrait",
                        ]
                            .map((type) => FormBuilderFieldOption(value: type))
                            .toList(growable: false),
                        onSaved: (value) {
                          _editTrans = FloozModel(
                            id: _editTrans.id,
                            somme: _editTrans.somme,
                            numero: _editTrans.numero,
                            typeOfTrans: value.toString(),
                          );
                        },
                      ),
                      // SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _saveAjouterTrans,
                          child: Text('Enregistrer'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

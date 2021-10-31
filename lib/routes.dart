import 'package:flutter/widgets.dart';

import '../screens/add_flooz_trans.dart';
import '../screens/flooz.dart';
import '../screens/Tmoney.dart';

final Map<String, WidgetBuilder> routes = {
  Flooz.routeName: (context) => Flooz(),
  Tmoney.routeName: (context) => Tmoney(),
  AddFloozTrans.routeName: (context) => AddFloozTrans(),
};

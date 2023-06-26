
import 'package:flutter/widgets.dart';
import 'package:siakad_sma_al_fusha/app/app.dart';
import 'package:siakad_sma_al_fusha/bootstrap.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  bootstrap(() => const App());
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsivescaffold/ui/main_page.dart';
import 'package:responsivescaffold/widget/responsive_scaffold.dart';

void main() async {
  Responsive.initialize(
      options: const ResponsiveOptions(
    desktopBreakpoint: 1024,
    tabletBreakpoint: 600,
    drawerWidth: 320,
  ));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              default:
                return MainPage();
            }
          },
        );
      },
    );
  }
}

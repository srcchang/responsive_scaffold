import 'package:flutter/material.dart';
import 'package:responsivescaffold/ui/end_drawer.dart';
import 'package:responsivescaffold/ui/home_page.dart';
import 'package:responsivescaffold/ui/main_drawer.dart';
import 'package:responsivescaffold/widget/responsive_scaffold.dart';

class MainPage extends StatelessWidget {
  final _responsiveScaffoldKey = GlobalKey<ResponsiveScaffoldState>();
  ResponsiveScaffoldState? get responsiveScaffold =>
      _responsiveScaffoldKey.currentState;

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, breakpoint) {
        return ResponsiveScaffold(
          key: _responsiveScaffoldKey,
          appBar: AppBar(
            title: const Text('AppBar'),
            leading: breakpoint != Breakpoint.desktop
                ? IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      responsiveScaffold?.openDrawer();
                    },
                  )
                : null,
            actions: breakpoint == Breakpoint.mobile
                ? [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        responsiveScaffold?.openEndDrawer();
                      },
                    ),
                  ]
                : null,
          ),
          drawer: MainDrawer(
            responsiveScaffold: _responsiveScaffoldKey,
          ),
          endDrawer: const EndDrawer(),
          body: const HomePage(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
        );
      },
    );
  }
}

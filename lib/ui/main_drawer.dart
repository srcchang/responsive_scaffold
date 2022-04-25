import 'package:flutter/material.dart';
import 'package:responsivescaffold/ui/grid_page.dart';
import 'package:responsivescaffold/ui/home_page.dart';
import 'package:responsivescaffold/ui/list_page.dart';
import 'package:responsivescaffold/widget/responsive_scaffold.dart';

class MainDrawer extends StatelessWidget {
  final GlobalKey<ResponsiveScaffoldState> responsiveScaffold;
  ResponsiveScaffoldState? get _state => responsiveScaffold.currentState;

  const MainDrawer({
    Key? key,
    required this.responsiveScaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, breakpoint) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home View'),
              onTap: () {
                if (breakpoint != Breakpoint.desktop) {
                  Navigator.pop(context);
                }
                _state?.pushReplacement(const HomePage());
              },
            ),
            ListTile(
              title: const Text('List View'),
              onTap: () {
                if (breakpoint != Breakpoint.desktop) {
                  Navigator.pop(context);
                }
                _state?.pushReplacement(const ListPage());
              },
            ),
            ListTile(
              title: const Text('Grid View'),
              onTap: () {
                if (breakpoint != Breakpoint.desktop) {
                  Navigator.pop(context);
                }
                _state?.pushReplacement(const GridPage());
              },
            ),
          ],
        );
      },
    );
  }
}

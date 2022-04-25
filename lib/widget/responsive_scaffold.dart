import 'package:flutter/material.dart';

const kTabletBreakpoint = 720.0;
const kDesktopBreakpoint = 1240.0;
const kDrawerWidth = 304.0;

enum Breakpoint { mobile, tablet, desktop }

class Responsive {
  final double desktopBreakpoint;
  final double tabletBreakpoint;
  final double drawerWidth;

  ResponsiveOptions? options;

  static Responsive get instance {
    return _instance!;
  }

  static Responsive? _instance;

  static Responsive initialize({ResponsiveOptions? options}) {
    if (_instance == null) {
      if (options != null) {
        _instance = Responsive._internal(
          desktopBreakpoint: options.desktopBreakpoint,
          tabletBreakpoint: options.tabletBreakpoint,
          drawerWidth: options.drawerWidth,
        );
      } else {
        _instance = Responsive._internal(
          desktopBreakpoint: kDesktopBreakpoint,
          tabletBreakpoint: kTabletBreakpoint,
          drawerWidth: kDrawerWidth,
        );
      }
    }
    return _instance!;
  }

  Responsive._internal({
    required this.desktopBreakpoint,
    required this.tabletBreakpoint,
    required this.drawerWidth,
  });
}

class ResponsiveOptions {
  final double desktopBreakpoint;
  final double tabletBreakpoint;
  final double drawerWidth;

  const ResponsiveOptions({
    this.desktopBreakpoint = kDesktopBreakpoint,
    this.tabletBreakpoint = kTabletBreakpoint,
    this.drawerWidth = kDrawerWidth,
  });
}

typedef ResponsiveWidgetBuilder = Widget Function(
    BuildContext context, Breakpoint breakpoint);

class ResponsiveWidget extends StatelessWidget {
  final ResponsiveWidgetBuilder builder;

  const ResponsiveWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.instance;
    final width = MediaQuery.of(context).size.width;
    if (width >= responsive.desktopBreakpoint) {
      return builder(context, Breakpoint.desktop);
    } else if (width >= responsive.tabletBreakpoint) {
      return builder(context, Breakpoint.tablet);
    } else {
      return builder(context, Breakpoint.mobile);
    }
  }
}

class ResponsiveScaffold extends StatefulWidget {
  final AppBar? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ResponsiveScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  State<ResponsiveScaffold> createState() => ResponsiveScaffoldState();
}

class ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState? get scaffold => _scaffoldKey.currentState;
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get navigator => _navigatorKey.currentState;

  void openDrawer() {
    scaffold?.openDrawer();
  }

  void openEndDrawer() {
    scaffold?.openEndDrawer();
  }

  void pushReplacement(Widget widget) {
    navigator?.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => widget,
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.instance;
    return WillPopScope(
      onWillPop: () async {
        return navigator?.maybePop() ?? Future.value(false);
      },
      child: ResponsiveWidget(
        builder: (context, breakpoint) {
          if (breakpoint == Breakpoint.desktop) {
            return Stack(
              children: [
                Row(
                  children: [
                    if (widget.drawer != null)
                      SizedBox(
                          width: responsive.drawerWidth,
                          child: Drawer(child: widget.drawer)),
                    Expanded(
                      child: Scaffold(
                        key: _scaffoldKey,
                        appBar: widget.appBar,
                        body: Row(
                          children: [
                            Expanded(
                              child: Navigator(
                                key: _navigatorKey,
                                onGenerateRoute: (RouteSettings settings) {
                                  return PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        widget.body ?? const SizedBox(),
                                    transitionDuration: Duration.zero,
                                  );
                                },
                              ),
                            ),
                            if (widget.endDrawer != null)
                              SizedBox(
                                  width: responsive.drawerWidth,
                                  child: Drawer(child: widget.endDrawer)),
                          ],
                        ),
                        floatingActionButton: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  widget.endDrawer != null ? kDrawerWidth : 0),
                          child: widget.floatingActionButton,
                        ),
                        floatingActionButtonLocation:
                            widget.floatingActionButtonLocation,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (breakpoint == Breakpoint.tablet) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: widget.appBar,
              body: Row(
                children: [
                  Expanded(
                    child: Navigator(
                      key: _navigatorKey,
                      onGenerateRoute: (RouteSettings settings) {
                        return PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              widget.body ?? const SizedBox(),
                          transitionDuration: Duration.zero,
                        );
                      },
                    ),
                  ),
                  if (widget.endDrawer != null)
                    SizedBox(
                        width: responsive.drawerWidth,
                        child: Drawer(child: widget.endDrawer)),
                ],
              ),
              drawer:
                  widget.drawer != null ? Drawer(child: widget.drawer) : null,
              floatingActionButton: Padding(
                padding: EdgeInsets.only(
                    right: widget.endDrawer != null ? kDrawerWidth : 0),
                child: widget.floatingActionButton,
              ),
              floatingActionButtonLocation: widget.floatingActionButtonLocation,
            );
          } else {
            return Scaffold(
              key: _scaffoldKey,
              appBar: widget.appBar,
              body: Navigator(
                key: _navigatorKey,
                onGenerateRoute: (RouteSettings settings) {
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        widget.body ?? const SizedBox(),
                    transitionDuration: Duration.zero,
                  );
                },
              ),
              drawer:
                  widget.drawer != null ? Drawer(child: widget.drawer) : null,
              endDrawer: widget.endDrawer != null
                  ? Drawer(child: widget.endDrawer)
                  : null,
              floatingActionButton: widget.floatingActionButton,
              floatingActionButtonLocation: widget.floatingActionButtonLocation,
            );
          }
        },
      ),
    );
  }
}

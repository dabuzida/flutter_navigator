import 'package:flutter/material.dart';
import 'package:flutter_navigator/page/page_configuration.dart';
import 'package:flutter_navigator/page/page_define.dart';
import 'package:flutter_navigator/page/page_instance.dart';

class PageRouterDelegate extends RouterDelegate<PageConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  PageRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    pageInstance.addListener(notifyListeners);
  }

  PageInstance pageInstance = PageInstance();

  TransitionDelegate transitionDelegate = NoAnimationTransitionDelegate();

  PageUri _currentPageUri = PageUri(PageName.waiting);

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  PageConfiguration get currentConfiguration {
    print('currentConfiguration: ${_currentPageUri.name}');

    if (!isValidPage(_currentPageUri.name)) {
      return PageConfiguration(PageName.home, _currentPageUri.params);
    }

    return PageConfiguration(_currentPageUri.name, _currentPageUri.params);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      transitionDelegate: transitionDelegate,
      pages: _makePages(),
      onPopPage: (Route<dynamic> route, dynamic result) {
        print('onPopPage');

        if (!route.didPop(result)) {
          return false;
        }

        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    print('setNewRoutePath: ${configuration.name}');

    setPageUri(configuration.name, params: configuration.params);
  }

  Page<void> _makePage(String name, Map<String, String>? params) {
    switch (name) {
      case PageName.invalid:
        return MaterialPage<void>(
          key: UniqueKey(),
          child: InvalidScreen(
            pageInstance: pageInstance,
            onNextPage: _movePage,
          ),
        );

      case PageName.home:
        return MaterialPage<void>(
          //key: ValueKey(PageName.login),
          key: UniqueKey(),
          child: HomeScreen(
            pageInstance: pageInstance,
            onNextPage: _movePage,
          ),
        );

      case PageName.deferredView1:
        return MaterialPage<void>(
          //key: ValueKey(PageName.login),
          key: UniqueKey(),
          child: DeferredScreen1(
            pageInstance: pageInstance,
            onNextPage: _movePage,
          ),
        );

      default:
        return MaterialPage<void>(
          key: UniqueKey(),
          child: const Text('default page'),
        );
    }
  }

  void setPageUri(String name, {Map<String, String>? params}) {
    _currentPageUri = PageUri(name, params: params);
    notifyListeners();
  }

  List<Page<void>> _makePages() {
    final List<Page<void>> pages = [];

    // for (var routePage in appInstance.routePages) {
    //   pages.add(_makePage(routePage.type, params: routePage.params));
    // }

    pages.add(_makePage(_currentPageUri.name, _currentPageUri.params));

    return pages;
  }

  Future<bool> _movePage(String nextName, {required Map<String, String>? nextParams}) async {
    if (nextName != PageName.login && nextName == PageName.ticketExpired) {
      if (!await isValidTicket()) {
        final Map<String, String> saveParams = Map<String, String>.from(nextParams!);
        saveParams['save'] = nextName;

        setPageUri(PageName.ticketExpired, params: saveParams);

        return true;
      }
    }

    if (!isValidPage(nextName)) {
      return false;
    }

    setPageUri(nextName, params: nextParams);

    return true;
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }

    for (final RouteTransitionRecord exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final List<RouteTransitionRecord>? pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }

      results.add(exitingPageRoute);
    }
    return results;
  }
}

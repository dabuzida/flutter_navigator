import 'package:flutter/material.dart';

import '../db/shared_store.dart';
import 'page_configuration.dart';
import 'page_define.dart';

class PageRouteInformationParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    print('parseRouteInformation: ${uri.path}');

    if (uri.pathSegments.length == 1) {
      return await _moveAsync(uri.pathSegments[0], params: uri.queryParameters);
    }

    if (await isValidTicket()) {
      return PageConfiguration(PageName.home, {
        //PageParamName.dashboardPage: '0',
      });
    }

    return PageConfiguration(PageName.home, uri.queryParameters);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    print('restoreRouteInformation: ${configuration.name}');

    if (!isValidPage(configuration.name)) {
      print('restoreRouteInformation failed: ${configuration.name}');
      return null;
    }

    return RouteInformation(location: makeUrl(configuration.name, params: configuration.params));
  }

  Future<PageConfiguration> _moveAsync(String baseUrl, {Map<String, String>? params}) async {
    if (baseUrl == PageName.ticketExpired) {
      return PageConfiguration(baseUrl, params);
    } else if (baseUrl == PageName.home) {
      if (!await isValidTicket()) {
        return PageConfiguration(baseUrl, params);
      }

      // save 정보를 조회해서 이전 경로가 조회되면 해당 경로를 복구하고, 그렇지 않다면 디폴트 경로로 이동한다.
      if (params == null || params['save'] == null) {
        return PageConfiguration(PageName.home, {
          //PageParamName.dashboardPage: '0',
        });
      } else {
        return PageConfiguration(params['save']!, params);
      }
    }

    if (!await isValidTicket()) {
      // 다른 페이지로 이동했는데 티켓이 없어서 로그인이 필요한 경우 params에 save를 추가해서 다시 이전 페이지로 복구할 수 있도록 한다.
      Map<String, String> saveParams = params != null ? Map.from(params) : Map();
      saveParams['save'] = baseUrl;

      await SharedStore.clearAll();

      return PageConfiguration(PageName.home, saveParams);
    }

    if (baseUrl == PageName.waiting) {
      print('baseUrl is waiting');
      return PageConfiguration(PageName.home, params);
    } else if (!isValidPage(baseUrl)) {
      print('baseUrl is invalid');
      return PageConfiguration(PageName.invalid, params);
    }

    return PageConfiguration(baseUrl, params);
  }

  String makeUrl(String baseUrl, {Map<String, String>? params}) {
    String url = '/$baseUrl';

    if (params != null) {
      bool isFirst = true;
      params.forEach((key, value) {
        if (isFirst) {
          url += '?$key=$value';
          isFirst = false;
        } else {
          url += '&$key=$value';
        }
      });
    }

    return url;
  }
}

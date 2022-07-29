import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../db/shared_store.dart';
import 'page_instance.dart';

//typedef NextPageCallback = void Function(String nextName, {Map<String, String>? nextParams});
typedef NextPageCallback = void Function(String nextName, {required Map<String, String>? nextParams});

class PageName {
  static const String invalid = 'invalid';
  static const String waiting = 'waiting';
  static const String home = 'home';
  static const String login = 'login';
  static const String ticketExpired = 'ticket-expired';
  static const String deferredView1 = 'deferred-view1';
}

class PageParamName {
  // page, id가 아닌 userPage, userId, ... 이렇게 따로 쓰는 이유는
  // campaign과 call 목록이 화면에 같이 나오는 경우가 있기 때문.
  static const String userPage = 'user_page';
  static const String userId = 'user_id';

  // 아직은 구별할 필요가 없지만 archiveOption도 추후 필요에 따라
  // campaignArchiveOption, callArchiveOption, ... 이렇게 나눠야 할 수도 있다.
  static const String archiveOption = 'archive_option';
}

class PageUri {
  PageUri(this.name, {this.params});
  final String name;
  final Map<String, String>? params;
}

bool isValidPage(String name) {
  switch (name) {
    case PageName.invalid:
    case PageName.waiting:
    case PageName.home:
    case PageName.ticketExpired:
    case PageName.deferredView1:
      return true;
  }

  return false;
}

Future<bool> isValidTicket() async {
  final String? ticket = await SharedStore.getString(SharedStoreKey.userTicket);
  if (ticket == null || ticket.isEmpty) {
    return false;
  }

  bool isValid = false;

  // await bogunsoAuthTicketValidate(
  //   onSuccess: (ack) async {
  //     isValid = true;
  //   },
  // );

  return isValid;
}

Uri makeUri(
  String pageName, {
  Map<String, String>? nextParams,
}) {
  String newUrl = '/\#/$pageName';

  if (nextParams != null) {
    bool isFirst = true;
    nextParams.forEach((key, value) {
      if (isFirst) {
        newUrl += '?$key=$value';
        isFirst = false;
      } else {
        newUrl += '&$key=$value';
      }
    });
  }

  return Uri.parse(newUrl);
}

void launchUrl(
  String pageName, {
  Map<String, String>? nextParams,
}) async {
  final String url = html.window.location.href;
  final List<String> splitUrls = url.split('\#');

  String newUrl = '${splitUrls[0]}\#/$pageName';

  if (nextParams != null) {
    bool isFirst = true;
    nextParams.forEach((key, value) {
      if (isFirst) {
        newUrl += '?$key=$value';
        isFirst = false;
      } else {
        newUrl += '&$key=$value';
      }
    });
  }

  if (await canLaunch(newUrl)) {
    await launch(newUrl);
  } else {
    throw 'Could not launch $newUrl';
  }
}

void linkUrl(
  PageInstance pageInstance,
  NextPageCallback onNextPage,
  String pageName, {
  Map<String, String>? nextParams,
}) {
  if (pageInstance.isPressedCtrl) {
    launchUrl(pageName, nextParams: nextParams);
  } else {
    onNextPage.call(pageName, nextParams: nextParams);
  }
}

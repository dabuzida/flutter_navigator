import '../global/config.dart';
import '../page/page_instance.dart';
import '../widget/input_cancellation_container.dart';
import 'package:universal_html/html.dart' as html;

import 'package:flutter/material.dart';

import 'ui_property.dart';

class WebScaffold extends StatefulWidget {
  final PageInstance pageInstance;
  final Widget? child;

  WebScaffold({
    Key? key,
    required this.pageInstance,
    this.child,
  }) : super(key: key);

  @override
  _WebScaffoldState createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  //late html.MutationObserver _mutationObserver;

  @override
  void initState() {
    //_mutationObserver = html.MutationObserver((List<dynamic> mutations, html.MutationObserver observer) => _translateHack());

    //WidgetsBinding.instance!.addPostFrameCallback((_) => _translateHack());

    html.document.addEventListener('keydown', controlDownEventHandler, false);
    html.document.addEventListener('keyup', controlUpEventHandler, false);
    html.document.addEventListener('mousedown', controlOnMouseDownEventHandler, false);

    super.initState();
  }

  @override
  void dispose() {
    html.document.removeEventListener('mousedown', controlOnMouseDownEventHandler);
    html.document.removeEventListener('keyup', controlUpEventHandler);
    html.document.removeEventListener('keydown', controlDownEventHandler);

    super.dispose();
  }

  void controlDownEventHandler(dynamic event) {
    print(event.metaKey);
    if (event.key == 'Control' || event.metaKey == true) {
      widget.pageInstance.isPressedCtrl = true;
    }
  }

  void controlUpEventHandler(dynamic event) {
    print(event.metaKey);
    if (event.key == 'Control' || event.metaKey == false) {
      widget.pageInstance.isPressedCtrl = false;
    }
  }

  void controlOnMouseDownEventHandler(dynamic event) {
    if (event.button == 2) {
      widget.pageInstance.isPressedCtrl = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          InputCancellationContainer(
            child: GestureDetector(
              onTapDown: (details) {
                print('onTapDown');
                widget.pageInstance.isPressedCtrl = false;
              },
              child: widget.child ?? SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: BuildConfig.isProductMode
                ? SizedBox.shrink()
                : IgnorePointer(
                    ignoring: true,
                    child: Padding(
                      padding: edgeInsetsM,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextL(
                          //   text: LocalizationString.buildModeDevelopment,
                          //   color: Colors.red,
                          //   bold: true,
                          // ),
                          // BuildConfig.isProductMode
                          //     ? SizedBox.shrink()
                          //     : TextL(
                          //         text: LocalizationString.buildModeDevelopment,
                          //         color: Colors.red,
                          //         fontWeight: FontWeight.bold,
                          //         shadows: [Preset.shadowPrimaryNarrow.value],
                          //       ),
                          // BuildConfig.isProductMode
                          //     ? SizedBox.shrink()
                          //     : TextM(
                          //         text: BuildConfig.lastBuildTime.millisecondsToDate(format: 'yyyy년 MM월 dd일 a hh시 mm분'),
                          //         color: Colors.red,
                          //         fontWeight: FontWeight.bold,
                          //         shadows: [Preset.shadowPrimaryNarrow.value],
                          //       ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

// void _translateHack() async {
//   List<html.Node> nodes = html.window.document.getElementsByTagName("*");
//
//   for (html.Node node in nodes) {
//     _mutationObserver.observe(node, childList: true);
//     html.Element el = node as html.Element;
//     if (el.style.transform.isEmpty) continue;
//     if (!el.style.transform.contains("\.")) continue;
//     //print(el.style.transform + " --> " + _normalizeTranslate(el.style.transform));
//     el.style.transform = _normalizeTranslate(el.style.transform);
//   }
// }
//
// String _normalizeTranslate(String value) {
//   if (value.length > 12) {
//     if (value.substring(0, 10) == "translate(") {
//       String p = value.replaceFirst("translate(", "").replaceFirst(")", "").replaceAll("px", "");
//       List<String> m = p.split(", ");
//       return "translate(" + (double.parse(m[0]).toInt()).toString() + "px, " + (double.parse(m[1]).toInt()).toString() + "px)";
//     } else if (value.substring(0, 12) == "translate3d(") {
//       String p = value.replaceFirst("translate3d(", "").replaceFirst(")", "").replaceAll("px", "");
//       List<String> m = p.split(", ");
//       return "translate3d(" + (double.parse(m[0]).toInt()).toString() + "px, " + (double.parse(m[1]).toInt()).toString() + "px, " + double.parse(m[2]).toInt().toString() + "px)";
//     }
//   }
//   return value;
// }
}

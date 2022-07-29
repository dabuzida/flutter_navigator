import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../media_query/media_query_layout.dart';
import '../page/page_define.dart';
import '../page/page_instance.dart';
import '../ui/ui_property.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
    required this.pageInstance,
    required this.onNextPage,
  }) : super(key: key);

  final PageInstance pageInstance;
  final NextPageCallback onNextPage;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String _url = 'tel:000-000-0000';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   child: Opacity(
        //     opacity: 0.15,
        //     child: Image(
        //       image: AssetImage('./images/login_bg.jpg'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        MediaQueryLayout(
          screenS: () {
            return Column(
              children: <Widget>[
                Container(
                  padding: edgeInsetsM,
                  height: 60.0,
                  child: const Text('Text in MediaQuery Small'),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      const Text('List Item in MediaQuery Small'),
                      ElevatedButton(onPressed: callToPhone, child: const Text('call')),
                      ElevatedButton(
                          child: const Text('deferredView1'),
                          onPressed: () {
                            widget.onNextPage.call(PageName.deferredView1, nextParams: null);
                          }),
                    ],
                  ),
                ),
              ],
            );
          },
          screenM: () {
            return ListView(
              children: <Widget>[
                _buildUILongHeader(),
                Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 10,
                      child: Text('Text 1 in MediaQuery Medium'),
                    ),
                    const Expanded(
                      flex: 10,
                      child: Text('Text 2 in MediaQuery Medium'),
                    ),
                    ElevatedButton(onPressed: callToPhone, child: const Text('call')),
                    ElevatedButton(
                        child: const Text('deferredView1'),
                        onPressed: () {
                          widget.onNextPage.call(PageName.deferredView1, nextParams: null);
                        }),
                  ],
                ),
              ],
            );
          },
          screenL: () {
            return ListView(
              children: [
                _buildUILongHeader(),
                Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 20,
                      child: Text('Text 1 in MediaQuery Large'),
                    ),
                    const Expanded(
                      flex: 80,
                      child: Text('Text 2 in MediaQuery Large'),
                    ),
                    const Expanded(
                      flex: 20,
                      child: Text('Text 3 in MediaQuery Large'),
                    ),
                    ElevatedButton(onPressed: callToPhone, child: const Text('call')),
                    ElevatedButton(
                        child: const Text('deferredView1'),
                        onPressed: () {
                          widget.onNextPage.call(PageName.deferredView1, nextParams: null);
                        }),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildUILongHeader() {
    return MediaQueryLayout(
      screenS: () {
        return const Text('LongHeader in MediaQuery Small');
      },
      screenM: () {
        return SizedBox(
          height: 60,
          child: Row(
            children: const <Widget>[
              Expanded(
                flex: 10,
                child: Text('LongHeader Item 1 in MediaQuery Medium'),
              ),
              Expanded(
                flex: 10,
                child: Text('LongHeader Item 2 in MediaQuery Medium'),
              ),
            ],
          ),
        );
      },
      screenL: () {
        return SizedBox(
          height: 60,
          child: Row(
            children: const <Widget>[
              Expanded(
                flex: 20,
                child: Text('LongHeader Item 1 in MediaQuery Large'),
              ),
              Expanded(
                flex: 20,
                child: Text('LongHeader Item 2 in MediaQuery Large'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> callToPhone() async {
    if (!await launch(_url)) {
      debugPrint('Could not launch $_url');
    }
  }
}

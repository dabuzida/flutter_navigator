import 'package:flutter/material.dart';
import '../home/home_view.dart' deferred as home_view;
import '../page/page_define.dart';
import '../page/page_instance.dart';
import '../ui/web_scafold.dart';
import '../widget/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.pageInstance,
    required this.onNextPage,
  }) : super(key: key);

  final PageInstance pageInstance;
  final NextPageCallback onNextPage;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends AppState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      pageInstance: widget.pageInstance,
      child: FutureBuilder<void>(
        future: home_view.loadLibrary(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return home_view.HomeView(pageInstance: widget.pageInstance, onNextPage: widget.onNextPage);
        },
      ),
    );
  }
}

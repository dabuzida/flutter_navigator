import 'package:flutter/material.dart';
import '../deferred_pages/deferred_view_1.dart' deferred as deferred_view_1;
import '../page/page_define.dart';
import '../page/page_instance.dart';
import '../ui/web_scafold.dart';
import '../widget/app_state.dart';

class DeferredScreen1 extends StatefulWidget {
  const DeferredScreen1({
    Key? key,
    required this.pageInstance,
    required this.onNextPage,
  }) : super(key: key);

  final PageInstance pageInstance;
  final NextPageCallback onNextPage;

  @override
  _DeferredScreen1State createState() => _DeferredScreen1State();
}

class _DeferredScreen1State extends AppState<DeferredScreen1> {
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
        future: deferred_view_1.loadLibrary(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return deferred_view_1.DeferredView1();
        },
      ),
    );
  }
}

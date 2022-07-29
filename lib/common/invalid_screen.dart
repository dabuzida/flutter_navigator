import 'package:flutter/material.dart';
import '../page/page_define.dart';
import '../page/page_instance.dart';
import '../ui/web_scafold.dart';
import '../widget/app_state.dart';

class InvalidScreen extends StatefulWidget {
  const InvalidScreen({
    Key? key,
    required this.pageInstance,
    required this.onNextPage,
  }) : super(key: key);

  final PageInstance pageInstance;
  final NextPageCallback onNextPage;

  @override
  State<InvalidScreen> createState() => _InvalidScreenState();
}

class _InvalidScreenState extends AppState<InvalidScreen> {
  bool _tryingLogout = true;

  @override
  void initState() {
    super.initState();

    _tryLogout();
  }

  void _tryLogout() {
    _tryingLogout = true;
    refresh();

    //await bogunsoAuthLogout();

    _tryingLogout = false;
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      pageInstance: widget.pageInstance,
      child: Container(
        child: const Text('data'),
        // color: Preset.colorBrightBG.value,
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         TextL(
        //           text: LocalizationString.guideInvalidPage,
        //           color: Preset.colorNeutralFont.value,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ],
        //     ),
        //     BlankColM(),
        //     ButtonM(
        //       text: LocalizationString.login,
        //       bgShadows: [Preset.shadowPrimaryNarrow.value],
        //       onPressed: () {
        //         //locator<GlobalNavigator>().pushNamed(PageName.home);
        //         widget.onNextPage.call(PageName.home);
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

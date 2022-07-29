import 'package:flutter/material.dart';

import 'custom_loading.dart';

abstract class AppState<T extends StatefulWidget> extends State<T> {
  LoadingTask? loadingTask;

  @override
  void initState() {
    super.initState();

    loadingTask = LoadingTask();

    loadingTask!.init(refresh);
  }

  @override
  void dispose() {
    // LoadingModalView.dismiss(loadingTask!, refresh: false);

    super.dispose();
  }

  void refresh() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void showLoading() {
    // LoadingModalView.show(context, loadingTask!);
  }

  void dismissLoading() {
    // LoadingModalView.dismiss(loadingTask!);
  }
}

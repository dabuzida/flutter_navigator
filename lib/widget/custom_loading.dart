import 'dart:async';

import 'package:flutter/material.dart';

typedef ReachedThresholdCallback = void Function(UniqueKey? loadingKey);

class LoadingTask extends ChangeNotifier {
  UniqueKey? loadingKey;
  int thresholdTime;
  int remainingTime;
  ReachedThresholdCallback? onReachedThreshold;

  bool isLoading = false;

  LoadingTask({
    this.loadingKey,
    this.thresholdTime: 8000,
    this.remainingTime: 0,
    this.onReachedThreshold,
  });

  void init(VoidCallback callback) {
    loadingKey = UniqueKey();

    addListener(callback);
  }

  void dismiss() {
    //LoadingModalView.dismiss(this);

    super.dispose();
  }

  void refresh() {
    notifyListeners();
  }
}

class LoadingModalView {
  static OverlayState? _state;
  static OverlayEntry? _entry;

  static Timer? _timer;

  static List<LoadingTask> _tasks = [];

  static void show(BuildContext context, LoadingTask loadingTask) {
    // 새로운 작업을 등록한다.
    bool found = false;

    for (int i = 0; i < _tasks.length; ++i) {
      LoadingTask task = _tasks[i];
      if (task == loadingTask) {
        task.remainingTime = task.thresholdTime;

        found = true;

        break;
      }
    }

    if (!found) {
      loadingTask.isLoading = true;

      _tasks.add(loadingTask);

      loadingTask.remainingTime = loadingTask.thresholdTime;
    }

    // 타이머가 돌고 있다면 리턴한다.
    if (_timer != null) {
      return;
    }

    // 0.2초 주기로 임계 시간에 도달하는지 체크한다.
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      for (int i = _tasks.length - 1; i >= 0; i--) {
        LoadingTask task = _tasks[i];
        task.remainingTime -= 200;
        if (task.remainingTime <= 0) {
          task.isLoading = false;
          loadingTask.refresh();

          task.onReachedThreshold?.call(task.loadingKey);

          _tasks.removeAt(i);
        }
      }

      if (_tasks.isEmpty) {
        if (_timer != null) {
          assert(_entry != null);

          _timer!.cancel();
          _timer = null;
        }

        if (_entry != null) {
          _entry!.remove();
          _entry = null;
        }
      }
    });

    // 로딩창을 보여준다.
    _state = Overlay.of(context);

    _entry = OverlayEntry(
      builder: (BuildContext overlayEntryContext) {
        return Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            //color: Preset.colorNormalOverlapBG.value,
            //margin: EdgeInsets.all(Preset.widgetIntervalM.value),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              //child: PrimaryIconProgressIndicator(),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    _state!.insert(_entry!);
  }

  // static dismiss(LoadingTask loadingTask, {refresh: true}) {
  //   for (int i = _tasks.length - 1; i >= 0; i--) {
  //     if (_tasks[i].loadingKey == loadingTask.loadingKey) {
  //       loadingTask.isLoading = false;

  //       if (refresh) {
  //         loadingTask.refresh();
  //       }

  //       _tasks.removeAt(i);
  //     }
  //   }

  //   if (_tasks.isEmpty) {
  //     if (_timer != null) {
  //       assert(_entry != null);

  //       _timer!.cancel();
  //       _timer = null;
  //     }

  //     if (_entry != null) {
  //       _entry!.remove();
  //       _entry = null;
  //     }
  //   }
  // }
}

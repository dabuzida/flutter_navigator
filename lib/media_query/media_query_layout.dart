import 'package:flutter/material.dart';

enum MediaQuerySizeType {
  unknown,
  s,
  m,
  l,
}

class MediaQueryLayout extends StatefulWidget {
  final Widget Function() screenS; // 0 이상 512 이하
  final Widget Function() screenM; // 512 이상 1024 이하
  final Widget Function() screenL; // 1024 이상
  final void Function(MediaQuerySizeType type)? onChanged;

  MediaQueryLayout({
    Key? key,
    required this.screenS,
    required this.screenM,
    required this.screenL,
    this.onChanged,
  }) : super(key: key);

  @override
  _MediaQueryLayoutState createState() => _MediaQueryLayoutState();
}

class _MediaQueryLayoutState extends State<MediaQueryLayout> {
  MediaQuerySizeType _mediaQuerySizeType = MediaQuerySizeType.unknown;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = MediaQuery.of(context).size.width;

        if (width >= 0.0 && width < 768.0) {
          _tryChanging(MediaQuerySizeType.s);

          return widget.screenS.call();
        } else if (width >= 768.0 && width < 1440.0) {
          _tryChanging(MediaQuerySizeType.m);

          return widget.screenM.call();
        } else if (width >= 1440.0) {
          _tryChanging(MediaQuerySizeType.l);

          return widget.screenL.call();
        }

        return widget.screenL.call();
      },
    );
  }

  void _tryChanging(MediaQuerySizeType type) {
    //print('_tryChanging(), $_mediaQuerySizeType, $type');

    if (_mediaQuerySizeType == type) {
      return;
    }

    _mediaQuerySizeType = type;

    widget.onChanged?.call(_mediaQuerySizeType);
  }
}

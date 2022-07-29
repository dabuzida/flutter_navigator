import 'package:flutter/material.dart';

class InputCancellationContainer extends StatelessWidget {
  const InputCancellationContainer({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

        onPressed?.call();
      },
      child: child,
    );
  }
}

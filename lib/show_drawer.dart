library show_drawer;
import 'package:flutter/widgets.dart';
import 'package:show_overlay/show_overlay.dart';

typedef DrawerCloser = Function();
typedef Builder = Widget Function(BuildContext, DrawerCloser);

DrawerCloser showDrawer(
  BuildContext context, {
  Widget child,
  Builder builder,
  Duration duration,
  Alignment alignment,
}) {
  // 至少传入一个
  assert(child != null || builder != null);

  return showOverlay(
    barrier: true,
    context: context,
    barrierBlur: true,
    barrierDismissible: true,
    duration: duration = Duration(milliseconds: 200),
    builder: builder ??
        (context, animation, closer) {
          return _Drawer(
            animation: animation,
            alignment: alignment,
            builder: builder,
            closer: closer,
            child: child,
          );
        },
  );
}

class _Drawer extends AnimatedWidget {
  final Widget child;
  final Closer closer;
  final Builder builder;
  final Alignment alignment;
  final Animation<double> animation;
  final curve = CurveTween(curve: Curves.easeInOutCirc);
  _Drawer({
    Key key,
    this.child,
    this.builder,
    this.closer,
    this.animation,
    this.alignment = Alignment.bottomCenter,
  }) : super(key: key, listenable: animation);

  get offsetTween {
    final target = this.alignment.toString();
    if (target == Alignment.bottomCenter.toString()) {
      return Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0));
    }
    if (target == Alignment.bottomLeft.toString()) {
      return Tween<Offset>(begin: Offset(-1, 1), end: Offset(0, 0));
    }
    if (target == Alignment.bottomRight.toString()) {
      return Tween<Offset>(begin: Offset(1, 1), end: Offset(0, 0));
    }
    if (target == Alignment.center.toString()) {
      // 为啥 -3? 我也不知道为啥
      return Tween<Offset>(begin: Offset(0, -3), end: Offset(0, 0));
    }
    if (target == Alignment.centerLeft.toString()) {
      return Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0));
    }
    if (target == Alignment.centerRight.toString()) {
      return Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
    }
    if (target == Alignment.topCenter.toString()) {
      return Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0));
    }
    if (target == Alignment.topLeft.toString()) {
      return Tween<Offset>(begin: Offset(-1, -1), end: Offset(0, 0));
    }
    if (target == Alignment.topRight.toString()) {
      return Tween<Offset>(begin: Offset(1, -1), end: Offset(0, 0));
    }
    // 默认从上部
    return Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0));
  }

  Widget build(BuildContext context) {
    return Align(
      alignment: this.alignment,
      child: SlideTransition(
        position: offsetTween.animate(animation.drive(curve)),
        child: builder != null ? builder(context, this.closer) : child,
      ),
    );
  }
}

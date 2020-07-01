library show_drawer;

import 'package:flutter/widgets.dart';
import 'package:show_overlay/show_overlay.dart';

/// [_Builder] 包含三个参数，第一个为 [BuildContext], 第二个为 [Animation<double>]
/// 第三个为 [Function], 执行 [Function] 可以移除当前的 [Drawer]
typedef _Builder = Widget Function(BuildContext, Animation<double>, Function);

Function showDrawer({
  @required BuildContext context,

  /// [builder] 提供 builder 来构建你的 widget
  _Builder builder,

  /// [animationDuration] 如果你使用动画，可以通过这个指定动画的执行时间
  Duration animationDuration,

  /// [alignment] 指定动画的方向
  Alignment alignment,

  // 可以为你的 Overlay 添加一个位于背景的遮罩层
  /// [barrier] 设置为 false 则不实用 barrier
  /// [barrierBlur] 指定 barrier 的背景模糊效果
  /// [barrierColor] 为你的 barrier 指定背景颜色
  /// [barrierDismissible] 指定是否可以通过点击 barrier 移除本 [OverlayEntry]
  double barrierBlur,
  Color barrierColor,
  bool barrier = true,
  bool barrierDismissible = true,
}) {
  assert(builder != null);

  return showOverlay(
    barrier: true,
    context: context,
    barrierDismissible: true,
    animationDuration: animationDuration ?? Duration(milliseconds: 200),
    builder: (context, animation, closer) {
      return _Drawer(
        animation: animation,
        alignment: alignment,
        builder: builder,
        closer: closer,
      );
    },
  );
}

class _Drawer extends AnimatedWidget {
  final Function closer;
  final _Builder builder;
  final Alignment alignment;
  final Animation<double> animation;
  final curve = CurveTween(curve: Curves.easeInOutCirc);
  _Drawer({
    Key key,
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
        child: builder(context, animation, this.closer),
        position: offsetTween.animate(animation.drive(curve)),
      ),
    );
  }
}

library show_drawer;

import 'package:flutter/widgets.dart';
import 'package:show_overlay/show_overlay.dart';

/// [DrawerBuilder] 包含三个参数，第一个为 [BuildContext], 第二个为 [Animation<double>]
/// 第三个为 [Function], 执行 [Function] 可以移除当前的 [Drawer]
typedef DrawerBuilder = Widget Function(
  BuildContext,
  Animation<double>,
  Function,
);

enum DrawerDirection {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  // center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

Function showDrawer({
  /// [builder] 提供 builder 来构建你的 widget
  @required BuildContext context,
  @required DrawerBuilder builder,

  /// 使用最根处的 [Overlay] 来展示
  bool useRootOverlay = false,

  /// [animationDuration] 如果你使用动画，可以通过这个指定动画的执行时间
  /// [animationCurve] 可以设置动画的 Curve 效果
  Duration animationDuration,
  Curve animationCurve = Curves.easeInOutCirc,

  /// [direction] 指定动画的方向
  DrawerDirection direction,

  // 可以为你的 Overlay 添加一个位于背景的遮罩层
  /// [barrier] 设置为 false 则不使用 barrier
  /// [barrierBlur] 指定 barrier 的背景模糊效果
  /// [barrierColor] 为你的 barrier 指定背景颜色
  /// [barrierDismissible] 指定是否可以通过点击 barrier 移除本 [OverlayEntry]
  double barrierBlur,
  Color barrierColor,
  bool barrier = true,
  bool barrierDismissible = true,
}) {
  return showOverlay(
    barrier: barrier,
    context: context,
    useRootOverlay: useRootOverlay,
    barrierDismissible: barrierDismissible,
    animationDuration: animationDuration ?? Duration(milliseconds: 200),
    builder: (context, animation, close) {
      return _AnimatedDrawer(
        close: close,
        animation: animation,
        direction: direction,
        curve: animationCurve,
        child: builder(context, animation, close),
      );
    },
  );
}

class _AnimatedDrawer extends AnimatedWidget {
  final Curve curve;
  final Widget child;
  final Function close;
  final DrawerDirection direction;
  final Animation<double> animation;

  _AnimatedDrawer({
    Key key,
    this.curve,
    this.close,
    this.child,
    this.animation,
    this.direction = DrawerDirection.topCenter,
  }) : super(key: key, listenable: animation);

  Alignment get alignment {
    switch (direction) {
      case DrawerDirection.topLeft:
        return Alignment.topLeft;
      case DrawerDirection.topCenter:
        return Alignment.topCenter;
      case DrawerDirection.topRight:
        return Alignment.topRight;
      case DrawerDirection.centerLeft:
        return Alignment.centerLeft;
      // case DrawerDirection.center:
      //   return Alignment.center;
      case DrawerDirection.centerRight:
        return Alignment.centerRight;
      case DrawerDirection.bottomLeft:
        return Alignment.bottomLeft;
      case DrawerDirection.bottomCenter:
        return Alignment.bottomCenter;
      case DrawerDirection.bottomRight:
        return Alignment.bottomRight;
    }

    return Alignment.topCenter;
  }

  Animation<Offset> get animationPosition {
    return Tween<Offset>(
      end: Offset(0.0, 0.0),
      begin: Offset(alignment.x, alignment.y),
    ).animate(
      animation.drive(
        CurveTween(
          curve: curve,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: alignment,
        child: SlideTransition(
          child: child,
          position: animationPosition,
        ),
      ),
    );
  }
}

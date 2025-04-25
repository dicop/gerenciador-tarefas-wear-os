import 'package:flutter/material.dart';

enum OverlayPosition { top, bottom }

enum OverlayDuration {
  short(2),
  normal(3),
  long(3),
  veryLong(5);

  final int value;
  const OverlayDuration(this.value);

  @override
  String toString() => 'OverlayDuration(value: $value seconds)';
}

class Alerter {
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconData? icon,
    double? iconSize,
    bool isIconAnimated = true,
    OverlayDuration duration = OverlayDuration.normal,
    OverlayPosition position = OverlayPosition.bottom,
  }) {
    OverlayView.createView(
      context,
      title: title,
      message: message,
      duration: duration,
      position: position,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      icon: icon,
      iconSize: iconSize,
      isIconAnimated: isIconAnimated,
    );
  }

  static void dismiss() => OverlayView.dismiss();
}

class OverlayView {
  static final OverlayView _singleton = OverlayView._internal();

  factory OverlayView() {
    return _singleton;
  }

  OverlayView._internal();

  static late OverlayState? _overlayState;

  static late OverlayEntry _overlayEntry;

  static bool _isVisible = false;

  static void createView(
    BuildContext context, {
    required String message,
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconData? icon,
    double? iconSize,
    bool? isIconAnimated,
    required OverlayDuration duration,
    required OverlayPosition position,
  }) {
    _overlayState = Navigator.of(context).overlay;
    if (_isVisible) dismiss();

    if (!_isVisible) {
      _isVisible = true;

      _overlayEntry = OverlayEntry(builder: (context) {
        return EdgeOverlay(
          title: title,
          message: message,
          duration: duration,
          position: position,
          backgroundColor: backgroundColor,
          textColor: textColor,
          iconColor: iconColor,
          icon: icon,
          iconSize: iconSize,
          isIconAnimated: isIconAnimated,
        );
      });

      _overlayState?.insert(_overlayEntry);
    }
  }

  static dismiss() async {
    if (!_isVisible) return;
    _isVisible = false;
    _overlayEntry.remove();
  }
}

class EdgeOverlay extends StatefulWidget {
  final String? title;

  final String message;

  final Color? backgroundColor;

  final Color? textColor;

  final Color? iconColor;

  final IconData? icon;

  final OverlayDuration duration;

  final OverlayPosition position;

  final double? iconSize;

  final bool? isIconAnimated;

  const EdgeOverlay({
    super.key,
    required this.message,
    this.title,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.icon,
    this.iconSize,
    this.isIconAnimated,
    required this.duration,
    required this.position,
  });

  @override
  State<EdgeOverlay> createState() => _EdgeOverlayState();
}

class _EdgeOverlayState extends State<EdgeOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<Offset> _positionTween;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    if (widget.position == OverlayPosition.top) {
      _positionTween = Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      );
    } else {
      _positionTween = Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: const Offset(0, 0),
      );
    }

    _positionAnimation = _positionTween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    listenToAnimation();

    super.initState();
  }

  void listenToAnimation() async {
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: widget.duration.value));
        if (!mounted) return;
        _controller.reverse();
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        OverlayView.dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomHeight = MediaQuery.of(context).padding.bottom;
    return Positioned(
      top: widget.position == OverlayPosition.top ? 0 : null,
      bottom: widget.position == OverlayPosition.bottom ? 0 : null,
      child: SlideTransition(
        position: _positionAnimation,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
            20,
            widget.position == OverlayPosition.top
                ? statusBarHeight + 20
                : bottomHeight + 20,
            20,
            widget.position == OverlayPosition.top ? 20 : 30,
          ),
          color: widget.backgroundColor ?? Colors.black87,
          child: OverlayWidget(
            title: widget.title,
            message: widget.message,
            icon: widget.icon,
            textColor: widget.textColor,
            iconColor: widget.iconColor,
            iconSize: widget.iconSize,
            isIconAnimated: widget.isIconAnimated,
          ),
        ),
      ),
    );
  }
}

class OverlayWidget extends StatelessWidget {
  final String? title;

  final String message;

  final IconData? icon;

  final Color? textColor, iconColor;

  final double? iconSize;

  final bool? isIconAnimated;

  const OverlayWidget({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.textColor,
    this.iconColor,
    this.iconSize,
    this.isIconAnimated,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          if (icon != null)
            AnimatedIcon(
              iconData: icon!,
              iconColor: iconColor,
              iconSize: iconSize,
              isIconAnimated: isIconAnimated ?? true,
            ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                Text(
                  message,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedIcon extends StatefulWidget {
  final IconData iconData;

  final Color? iconColor;

  final bool isIconAnimated;

  final double? iconSize;

  const AnimatedIcon({
    super.key,
    required this.iconData,
    this.iconColor,
    this.iconSize,
    required this.isIconAnimated,
  });

  @override
  AnimatedIconState createState() => AnimatedIconState();
}

class AnimatedIconState extends State<AnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.1,
      duration: const Duration(milliseconds: 600),
    );
    if (widget.isIconAnimated) {
      _controller.forward();
      listenToAnimation();
    }
  }

  listenToAnimation() async {
    _controller.addStatusListener((listener) async {
      if (listener == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (listener == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: (widget.iconSize ?? 0) > 20 ? 15 : 10),
      child: AnimatedBuilder(
        animation: _controller,
        child: Icon(
          widget.iconData,
          size: widget.iconSize ?? 35,
          color: widget.iconColor ?? Colors.white,
        ),
        builder: (context, widget) => Transform.scale(
          scale: _controller.value,
          child: widget,
        ),
      ),
    );
  }
}
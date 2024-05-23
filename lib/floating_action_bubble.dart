import 'package:flutter/material.dart';

class FloatingActionBubbleDemo extends AnimatedWidget {
  const FloatingActionBubbleDemo({
    super.key,
    required this.items,
    required this.onPress,
    required this.iconColor,
    required this.backGroundColor,
    required Animation<double> animation,
    required this.gap,
    this.herotag,
    this.iconData,
    this.animatedIconData,
    this.offset = const Offset(0, 0),
  })  : assert((iconData == null && animatedIconData != null) ||
            (iconData != null && animatedIconData == null)),
        super(listenable: animation);

  final List<Bubble> items;
  final void Function() onPress;
  final AnimatedIconData? animatedIconData;
  final Object? herotag;
  final IconData? iconData;
  final Color iconColor;
  final Color backGroundColor;
  final Offset offset;
  final int gap;

  double get _animation => (listenable as Animation<double>).value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (int i = items.length - 1; i >= 0; i--)
          buildItem(context, i, gap), // Reverse order
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            shape: const CircleBorder(side: BorderSide.none),
            backgroundColor: backGroundColor,
            onPressed: onPress,
            child: iconData == null
                ? AnimatedIcon(
                    icon: animatedIconData!,
                    progress: listenable as Animation<double>,
                    color: iconColor,
                  )
                : Icon(
                    iconData,
                    color: iconColor,
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildItem(BuildContext context, int index, int count) {
    final screenWidth = MediaQuery.of(context).size.width;

    TextDirection textDirection = Directionality.of(context);

    double animationValue = _animation;

    // Correct animationDirection calculation for both LTR and RTL
    double animationDirection = textDirection == TextDirection.ltr
        ? animationValue
        : (1 - animationValue);

    final transform = Matrix4.translationValues(
      -animationDirection * screenWidth * ((items.length - index) / count) -
          1 +
          offset.dx, // Remove (1 - animationDirection) *
      offset.dy,
      0, // Set Z-axis to 0 for correct stacking
    );

    return Align(
      alignment: Alignment.bottomRight, // Align to bottom center
      child: Transform(
        transform: transform,
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2),
            opacity: _animation.clamp(
                0.0, 1.0), // Clamp the value between 0.0 and 1.0
            child: BubbleMenu(items[index])),
      ),
    );
  }
}

/// Creates a bubble item for floating action menu button.
class Bubble {
  const Bubble({
    required IconData icon,
    required Color iconColor,
    required Color bubbleColor,
    required this.onPress,
  })  : _icon = icon,
        _iconColor = iconColor;

  final IconData _icon;
  final Color _iconColor;
  final void Function() onPress;
}

/// Creates a bubble menu for all the items for floating action menu button.
class BubbleMenu extends StatelessWidget {
  const BubbleMenu(this.item, {super.key});

  final Bubble item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 5),
      child: InkWell(
        onTap: item.onPress,
        child: Container(
          height: 38,
          width: 38,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
          ),
          child: Icon(
            item._icon,
            color: item._iconColor,
          ),
        ),
      ),
    );
  }
}

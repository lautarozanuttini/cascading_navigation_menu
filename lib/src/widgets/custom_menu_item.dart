import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  /// Title of the item to show in menu
  final String? title;

  final int? index;
  final int? id;
  final bool isOpen;
  final bool isSubmenu;
  final double height;
  final double width;
  final Color color;
  final Color fontColor;
  final Color fontColorPressed;
  final IconData? leadingIcon;
  final IconData? icon;
  final double iconSize;
  final ValueChanged<int?>? onPress;
  final ValueChanged<int?>? onChildPress;
  final ValueChanged<int?>? callback;
  const CustomMenuItem({
    super.key,
    this.title,
    required this.isOpen,
    required this.height,
    required this.width,
    required this.isSubmenu,
    required this.color,
    this.id,
    this.onPress,
    this.onChildPress,
    this.index,
    this.fontColor = Colors.black,
    this.fontColorPressed = Colors.white,
    this.icon,
    this.leadingIcon,
    this.iconSize = 16,
    this.callback,
  }) : assert(!(title == null && icon == null), "Must have title or Icon");

  void onPressItem(int? i) {
    if (!isSubmenu) {
      onPress!(index);
      if (callback != null) callback!(index);
    } else {
      onChildPress!(id);
      if (callback != null) callback!(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (leadingIcon != null) {
      items.add(Icon(
        leadingIcon,
        color: isOpen && !isSubmenu ? fontColorPressed : fontColor,
        size: iconSize,
      ));
      items.add(
        const SizedBox(
          width: 5,
        ),
      );
    }

    if (title != null) {
      items.add(
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isOpen && !isSubmenu ? fontColorPressed : fontColor,
            fontSize: 12,
          ),
        ),
      );
    }

    if (icon != null) {
      items.add(
        const SizedBox(
          width: 5,
        ),
      );
      items.add(
        Icon(
          icon,
          color: isOpen && !isSubmenu ? fontColorPressed : fontColor,
          size: iconSize,
        ),
      );
    }

    Widget main;

    main = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items,
    );

    return GestureDetector(
      onTap: () => onPressItem(id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width,
        height: height,
        color: isOpen ? color : color,
        child: main,
      ),
    );
  }
}

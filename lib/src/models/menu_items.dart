import 'package:cascading_navigation_menu/src/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  late List<MenuItem> items;

  MenuItems() {
    items = [];
  }

  void addNewMenuItem({
    required int id,
    String? title,
    IconData? leadingIcon,
    IconData? icon,
    double? iconSize,
    bool? submenu,
    required String description,
    String? imagen,
    String? link,
    List<MenuItem>? body,
    required Widget child,
    ValueChanged<int?>? onPress,
  }) {
    items.add(
      MenuItem(
        id: id,
        title: title,
        leadingIcon: leadingIcon,
        icon: icon,
        iconSize: iconSize,
        submenu: submenu,
        description: description,
        imagen: imagen,
        link: link,
        body: body ?? [],
        child: child,
        onPress: onPress
      ),
    );
  }
}

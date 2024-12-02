import 'package:flutter/material.dart';

class MenuItem {
  int id;
  String? title;
  IconData? leadingIcon;
  IconData? icon;
  double? iconSize;
  bool? submenu;
  String description;
  String? imagen;
  String? link;
  List<MenuItem> body;
  Widget child;
  ValueChanged<int?>? onPress;

  MenuItem({
    required this.id,
    this.title,
    this.leadingIcon,
    this.icon,
    this.iconSize,
    this.submenu,
    required this.description,
    this.imagen,
    this.link,
    this.body = const [],
    required this.child,
    this.onPress,
  });
}
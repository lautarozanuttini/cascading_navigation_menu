import 'package:cascading_navigation_menu/src/models/menu_items.dart';
import 'package:cascading_navigation_menu/src/widgets/custom_menu_item.dart';
import 'package:flutter/material.dart';

class CascadingMenu extends StatefulWidget {
  /// Items childs of menu this must not be empty [required]
  final MenuItems menu;

  /// If want to show title of the child widget to show
  final bool showTitle;
  // Color of background menu
  final Color? color;
  // Color of the menu font text not selected
  final Color? fontColor;
  // Color of the menu font text selected
  final Color? fontColorPressed;
  final double width;
  final double height;
  CascadingMenu({
    super.key,
    required this.menu,
    this.showTitle = true,
    this.color,
    this.fontColor,
    this.fontColorPressed,
    this.width = 200,
    this.height = 40,
  })  : assert(menu.items.isNotEmpty, "Header must have items"),
        assert(width >= 80, "Width must be bigger than 80px"),
        assert(height >= 40, "Height must be bigger than 40px");

  @override
  State<CascadingMenu> createState() => _ManualMenuState();
}

class _ManualMenuState extends State<CascadingMenu> {
  /// Variable type [bool] that controls if menu is open or not
  late bool _openMenu;
  late double _height;
  late double _width;

  /// Color of the menu this will take context primary color if is not set
  late Color _color;

  /// Number of the index menu that have to open not the selected
  int? _menuSelected;

  /// Number of the index sub menu where is select
  int? _subMenuSelected;

  /// Number of the child index select
  int? _childSelected;

  @override
  void initState() {
    super.initState();
    _openMenu = false;
    _width = widget.width;
    _height = widget.height;
    _color = widget.color ?? Theme.of(context).primaryColor;
    _menuSelected = 0;
    _subMenuSelected = 0;
  }

  void onItemClick(int? val) {
    if (val != null && widget.menu.items[val].body.isEmpty) {
      _childSelected = val;
    }
    _openMenu = val == null ? false : true;
    _menuSelected = val;
    setState(() {});
  }

  void onItemChildClick(int? val) {
    if (_childSelected != null && val != null) {
      _childSelected = null;
    }

    if (val != null) {
      _subMenuSelected = val;
    }
    _openMenu = false;
    setState(() {});
  }

  /// When mouse leaves submenu item to
  /// widget child this function close menu
  void onChildEnter(e) {
    if (_openMenu) {
      setState(() {
        _openMenu = false;
      });
    }
  }

  /// Calculate of the space between top of the window
  /// and the submenu item setting Y axis position
  int calculatePosition() {
    int emptySpaces = (_height).round() * _menuSelected!;
    if (MediaQuery.of(context).size.height < 780 && _menuSelected! > 5) {
      emptySpaces = _height.round() *
          (_menuSelected! - widget.menu.items[_menuSelected!].body.length + 1);
    }
    return emptySpaces;
  }

  Widget _getMenuItems() {
    List<Widget> menues = [];
    List<Widget> childs = [];

    if (_childSelected != null &&
        widget.menu.items[_childSelected!].body.isEmpty) {
      childs.add(
        Positioned(
          left: _width,
          child: MouseRegion(
            onEnter: onChildEnter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - _width - 30,
                height: MediaQuery.of(context).size.height - 30,
                child: widget.showTitle &&
                        widget.menu.items[_childSelected!].title != null
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.menu.items[_childSelected!].title!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          widget.menu.items[_childSelected!].child
                        ],
                      )
                    : widget.menu.items[_childSelected!].child,
              ),
            ),
          ),
        ),
      );
    } else if (_subMenuSelected != null) {
      childs.add(
        Positioned(
          left: _width,
          child: MouseRegion(
            onEnter: onChildEnter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - _width - 30,
                height: MediaQuery.of(context).size.height - 30,
                child: widget.showTitle &&
                        _subMenuSelected != null &&
                        widget.menu.items[_menuSelected!].body.isNotEmpty &&
                        widget.menu.items[_menuSelected!]
                                .body[_subMenuSelected!].title !=
                            null
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.menu.items[_menuSelected!]
                                    .body[_subMenuSelected!].title!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          widget.menu.items[_menuSelected!]
                              .body[_subMenuSelected!].child
                        ],
                      )
                    : widget.menu.items[_menuSelected!].child,
              ),
            ),
          ),
        ),
      );
    }

    for (int i = 0; i < widget.menu.items.length; i++) {
      bool isOpen = false;
      if (_openMenu && _menuSelected == i) isOpen = true;
      menues.add(
        CustomMenuItem(
          title: widget.menu.items[i].title,
          index: i,
          isOpen: isOpen,
          onPress: onItemClick,
          leadingIcon: widget.menu.items[i].leadingIcon,
          icon: widget.menu.items[i].icon,
          color: _color,
          isSubmenu: false,
          width: _width,
          height: _height,
          callback: widget.menu.items[i].onPress,
        ),
      );
    }

    Widget menuColumn = Positioned(
      left: 0,
      child: Container(
        color: _color,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: menues,
        ),
      ),
    );
    childs.add(menuColumn);

    if (_openMenu) {
      int emptySpaces = calculatePosition();
      childs.add(
        Positioned(
          left: _width,
          top: emptySpaces.toDouble(),
          child: MouseRegion(
            onExit: (e) => {onItemChildClick(null)},
            child: Column(
              children: widget.menu.items[_menuSelected!].body
                  .map((e) => CustomMenuItem(
                        title: e.title,
                        id: e.id,
                        index: _menuSelected,
                        isOpen: true,
                        color: _color,
                        leadingIcon: e.leadingIcon,
                        icon: e.icon,
                        onChildPress: onItemChildClick,
                        isSubmenu: true,
                        width: _width,
                        height: _height,
                        callback: widget.menu.items[_menuSelected!]
                            .body[_subMenuSelected!].onPress,
                      ))
                  .toList(),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: childs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getMenuItems(),
      ],
    );
  }
}

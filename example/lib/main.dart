import 'package:cascading_navigation_menu/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MenuItems menu;

  @override
  void initState() {
    super.initState();
    menu = MenuItems();
    menu.addNewMenuItem(
        id: 1,
        title: "Item 1",
        leadingIcon: Icons.electric_bike,
        submenu: false,
        description: "Item 1",
        child: const Text("Item 1"));
    MenuItems items = MenuItems();
    items.addNewMenuItem(
        id: 0,
        icon: Icons.bike_scooter,
        title: "Subitem 1",
        submenu: true,
        description: "Subitem 1",
        child: const Text("Subitem 1"));
    items.addNewMenuItem(
        id: 1,
        title: "Subitem 2",
        submenu: true,
        description: "Subitem 2",
        child: const Text("Subitem 2"));
    menu.items[0].body = items.items;
    menu.addNewMenuItem(
      id: 2,
      title: "Item 2",
      submenu: false,
      description: "Item 2",
      child: const Text("Item 2"),
      onPress: (int? i) {
        print("item2 presionado");
      },
    );
    menu.addNewMenuItem(
      id: 3,
      submenu: false,
      icon: Icons.electric_scooter,
      description: "Item 3",
      child: const Text("Item 3"),
      onPress: (int? i) {
        print("item3 presionado");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cascade navigation menu"),
        ),
        body: CascadingMenu(
          menu: menu,
          color: Colors.green,
        ),
      ),
    );
  }
}

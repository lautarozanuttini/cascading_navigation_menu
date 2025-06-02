# Cascading Navigation Menu

Flutter package to show a left side menu widget with sub-menues.

---

## Platform Support

| Platform | Supported |
|----------|-----------|
| Windows  | ✅         |
| Web      | ✅         |

---

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  cascading_navigation_menu: <latest-version>
```
Import the package:

```dart
import 'package:cascading_navigation_menu/main.dart';
```

## Usage

Import to your code the main widget:

```dart
import 'package:cascading_navigation_menu/main.dart';
```

Create a list of item and add them:

```dart
late MenuItems menu;
...
menu = MenuItems();
menu.addNewMenuItem(
    id: 1,
    title: "Item 1",
    leadingIcon: Icons.electric_bike,
    submenu: false,
    description: "Item 1",
    child: const Text("Item 1"),
);
```

Then put them in the main widget

```dart
CascadingMenu(
    menu: menu,
    color: Colors.green,
),
```
---

## Elements

### Main element

menu: Attribute that contains the items to show.
showTitle: Show/hide title of the child in the body, by default true.
color: Menu´s background color, by default primaryColor.
fontColor: Font´s color not pressed title, by default black.
fontColorPressed: Font´s color if items is selected, by default white.
width: Width size of menu, by default 200px.
height: Height size of menu childs, by default 40.

```dart
CascadingMenu({
  Key? key,
  required MenuItems menu,
  bool showTitle = true,
  Color? color,
  Color? fontColor,
  Color? fontColorPressed,
  double width = 200,
  double height = 40,
})
```

### Menu item

```dart
MenuItem({
    required int id,
    String? title,
    IconData? leadingIcon,
    IconData? icon,
    double? iconSize,
    bool? submenu,
    required String description,
    String? imagen,
    String? link,
    List<MenuItem> body = const [],
    required Widget child,
    void Function(int?)? onPress,
})
```

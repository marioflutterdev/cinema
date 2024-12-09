import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({
    super.key,
  });

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SalomonBottomBar(
        selectedItemColor: colors.primary,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          _onTapToView(context, value);
        },
        items: _navBarItems);
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home_max),
    title: const Text('Home'),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.label_important_outline_sharp),
    title: const Text('Categorias'),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite_border_sharp),
    title: const Text('Favoritos'),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.tune_outlined),
    title: const Text('Configuraciones'),
  ),
];
void _onTapToView(BuildContext context, int value) {
  switch (value) {
    case 0:
      context.go("/");
      break;
    case 1:
      context.go("/categories");
      break;
    case 2:
      context.go("/favorites");
      break;
    case 3:
      context.go("/settings");
      break;
  }
}

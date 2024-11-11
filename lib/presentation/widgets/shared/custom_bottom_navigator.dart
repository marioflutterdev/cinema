import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatelessWidget {
  const CustomBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_important_outline_sharp),
          label: 'Categorías'
        ),
        /*  */
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favoritos'
        )
      ],
    );
  }
}

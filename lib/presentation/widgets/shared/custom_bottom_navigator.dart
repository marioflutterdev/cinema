import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigator extends StatelessWidget {
  
  const CustomBottomNavigator({
    super.key,
  });
  void  _onTapToView(BuildContext context, int value ){
    
    switch(value) {
      case 0:
      context.go("/");
        break;
      case 1:
      context.go("/categories");
        break;
      case 2:
      context.go("/favorites");
        break;
     
    }

  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      onTap: (value) => _onTapToView(context, value),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_important_outline_sharp),
            label: 'Categorías'),
        /*  */
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: 'Favoritos')
      ],
    );
  }
}

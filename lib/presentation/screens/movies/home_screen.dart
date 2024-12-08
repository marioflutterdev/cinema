import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/view/view.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

const List<Widget> view = [HomeView(), CategoriesView(), FavoriteView()];

class HomeScreen extends StatefulWidget {
  final Widget child ;

  static const name = 'home-screen';
  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* late PageController pageController;
  @override
  void initState() {
    pageController = PageController(
      keepPage: true
    );
    super.initState();
  } */
  @override
  Widget build(BuildContext context) {
    print(widget.child);
   /*  if(pageController.hasClients){
    pageController.animateTo(
      1,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
    } */
    
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: const CustomBottomNavigator(),
    );
  }
}

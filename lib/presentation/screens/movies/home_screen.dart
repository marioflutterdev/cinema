import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/view/view.dart';

const List<Widget> view = [HomeView(), CategoriesView(), FavoriteView()];

class HomeScreen extends StatefulWidget {
  final Widget child;

  static const name = 'home-screen';
  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: const CustomBottomNavigator(),
    );
  }
}

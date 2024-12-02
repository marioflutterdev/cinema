import 'package:cinemapedia/presentation/delegates/movie_home_search_delegate.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Icon(
              Icons.movie_creation_outlined,
              color: colors.primary,
            ),
            const SizedBox(width: 5),
            Text(
              "CinemaPedia",
              style: titleStyle,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MovieHomeSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }
}

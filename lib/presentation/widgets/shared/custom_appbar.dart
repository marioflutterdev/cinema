import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/delegates/movie_home_search_delegate.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
                final movieRepository = ref.read(movieRepositoryProvider);

                showSearch<Movie?>(
                    query: 'batman',
                    context: context,
                    delegate: MovieHomeSearchDelegate(
                      searchMovies: (query) {
                        return movieRepository.getMovieSearch(query);
                      },
                    )).then((movie) {
                  if (movie == null) return;
                  if (!context.mounted) return; 
                    context.push('/movie/${movie.id}');
                  
                });
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }
}

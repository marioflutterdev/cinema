import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallBack = Future<List<Movie>> Function(String query);

class MovieHomeSearchDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallBack searchMovies;
  final List<Movie> initialMovies;

  MovieHomeSearchDelegate({
    required this.initialMovies,
    required this.searchMovies,
  }):super(
    searchFieldLabel: 'Buscar Películas'
  );

  final StreamController<List<Movie>> debouncedMovies =
      StreamController.broadcast();
  Timer? debounceTimer;
  
  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryDebounce(String query) {
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();

    debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        

        final movies = await searchMovies(query);
        debouncedMovies.add(movies);
      },
    );
  }

  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildSuggestions");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryDebounce(query);

    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => FadeInUp(
            duration: const Duration(milliseconds: 300 ),
            child: _MovieInfo(
              movie: movies[index],
              onMovieselected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            ),
          ),
        );
      },
    );
  }
}

class _MovieInfo extends StatelessWidget {
  final Movie movie;
  final Function onMovieselected;

  const _MovieInfo({
    required this.movie,
    required this.onMovieselected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        onMovieselected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(movie.posterPath),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length >= 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined,
                          color: Colors.yellow.shade700),
                      const SizedBox(height: 10),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyle.titleMedium!
                            .copyWith(color: Colors.yellow.shade800),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

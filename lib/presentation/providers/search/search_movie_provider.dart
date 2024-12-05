import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMovieProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
    ref: ref,
    searchMovies: movieRepository.getMovieSearch,
  );
});

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMovieCallback searchMovies;
  final Ref ref;
  SearchedMoviesNotifier({
    required this.ref,
    required this.searchMovies,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    ref.read(searchMovieProvider.notifier).update((state) => query);
    final List<Movie> movies = await searchMovies(query);
    state = movies;
    return movies;
  }
}




import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref){
  final movieRepository = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovie: movieRepository );
});



typedef  GetMovieCallBack = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map <String,Movie>> {
  final GetMovieCallBack getMovie;
  
  MovieMapNotifier({required this.getMovie}): super({});
   
   Future<void> loadMovie( String id) async{
    if ( state[id] != null) return; 

    final movie = await getMovie(id);
    state = {...state, id: movie};
   }
} 
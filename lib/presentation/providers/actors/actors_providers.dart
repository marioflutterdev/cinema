import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsMapNotifier, Map<String, List<Actors>>>((ref) {
  final actorsrepository = ref.watch(actorsRepositoryProvider);
  return ActorsMapNotifier(getActors: actorsrepository.getActorsByMovie);
});

typedef ActorsCallBack = Future<List<Actors>> Function(String id);

class ActorsMapNotifier extends StateNotifier<Map<String, List<Actors>>> {
  final ActorsCallBack getActors;

  ActorsMapNotifier({required this.getActors}) : super({});

  Future<void> getActorsByMovie(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actors> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}

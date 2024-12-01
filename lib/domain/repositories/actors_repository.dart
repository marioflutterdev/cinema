import 'package:cinemapedia/domain/entities/actors.dart';

abstract class ActorsRepository {
    Future<List<Actors>> getActorsByMovie( String movie);

}
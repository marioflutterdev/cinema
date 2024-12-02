import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/actors_response.dart';

class ActorsMapper {
  static Actors actorsDBToEntity(Cast cast) => Actors(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://www.engineering.iastate.edu/people/files/2020/01/no-photo.jpg',
      character: cast.character);
}

import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/actors_response.dart';

class ActorsMapper {
  static Actors actorsDBToEntity(Cast cast) => Actors(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://i.pinimg.com/originals/ac/11/aa/ac11aa2add3b0193c8769e0a17d13535.jpg',
      character: cast.character);
}

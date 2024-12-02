import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/actorsdb_datasource.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  
   final ActorsdbDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});
  
  @override
  Future<List<Actors>> getActorsByMovie(String movie) async {
  return datasource.getActorsByMovie(movie);
  }
}
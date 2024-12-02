import 'package:cinemapedia/infrastructure/mappers/actors_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/actors_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actors.dart';

class ActorsdbDatasource  extends ActorsDatasource{
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      },
    ),
  );
  
  
  @override
  Future<List<Actors>> getActorsByMovie(String movie)async {


    final response = await dio.get('/movie/$movie/credits');

    final castResponse = ActorsDetails.fromJson(response.data); 

    List<Actors> actors = castResponse.cast.map(
      (actor) => ActorsMapper.actorsDBToEntity(actor)
      ).toList();

    return actors;
  }
}
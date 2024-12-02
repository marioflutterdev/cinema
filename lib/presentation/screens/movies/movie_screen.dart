import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = "movie-screen";

  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).getActorsByMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _AppBarCustom(movie: movie),
          _SliverListMovieDescription(movie: movie),
        ],
      ),
    );
  }
}

class _AppBarCustom extends StatelessWidget {
  final Movie movie;
  const _AppBarCustom({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.originalTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // centerTitle: false,
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const CircularProgressIndicator();
                  }
                  return child;
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                    stops: [0.1, 0.3],
                    colors: [
                      Colors.black38,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverListMovieDescription extends StatelessWidget {
  final Movie movie;
  const _SliverListMovieDescription({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
                children: [
                  _BodyDescriptionMovie(movie: movie),
                   _ActorsListView( movieId: movie.id.toString(),)
                ],
              ),
          childCount: 1),
    );
  }
}

class _ActorsListView extends ConsumerWidget {

  final String movieId;
  const _ActorsListView( 
    {
      required this.movieId,
  });


  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    
    if( actorsByMovie[movieId] == null){
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieId];

    
    return SizedBox(
      height: size.height * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: double.infinity,
              width: size.width * 0.3 ,
              child: FadeInRight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        actors[index].profilePath,
                        fit: BoxFit.cover,
                        width: size.width * 0.3,
                        height: size.width * 0.5,
                      ),
                    ),
                    Text(actors[index].name),
                    Text(actors[index].character!, style: const TextStyle(fontWeight:FontWeight.bold ),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BodyDescriptionMovie extends StatelessWidget {
  const _BodyDescriptionMovie({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: size.width * 0.3,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: size.width * 0.7 - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.originalTitle, style: textStyle.titleLarge),
                    Text(movie.overview, style: textStyle.titleSmall)
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              ...movie.genreIds.map(
                (e) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Chip(label: Text(e)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

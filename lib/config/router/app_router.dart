import 'package:cinemapedia/presentation/view/movies/favorite_view.dart';
import 'package:cinemapedia/presentation/view/movies/home_view.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MovieScreen.name,
                builder: (context, state) =>
                    MovieScreen(movieId: state.params['id'] ?? "no-id"),
              )
            ],
          ),
          GoRoute(
            path: '/categories',
            builder: (context, state) => const FavoriteView(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoriteView(),
          ),
        ])
  ],
);

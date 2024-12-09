import 'package:go_router/go_router.dart';


import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/view/view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(child: navigationShell);
          
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) => MovieScreen(
                      movieId: state.pathParameters['id'] ?? "no-id"),
                )
              ],
            ),
          ]),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/categories",
                builder: (context, state) => const CategoriesView(),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/favorites",
                builder: (context, state) => const FavoriteView(),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                builder: (context, state) => const SettingView(),
              )
            ],
          )
        ])
  ],
);

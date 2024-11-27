import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {

  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topratedMoviesProvider).isEmpty;
  final step5 = ref.watch(moviesSlideshowProvider).isEmpty;

  if ( step2 || step3 || step4 || step5) return true;

  return false; //terminamos de cargar
});

class Actors {
  final int id;
  final String name;
  final String profilePath;
  final String? character;

  Actors({
    required this.id,
    required this.name,
    required this.profilePath,
    this.character,
  });
}

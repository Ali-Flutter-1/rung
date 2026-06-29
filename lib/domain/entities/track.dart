/// A fear category containing an ordered ladder of rungs (§2.4).
class Track {
  const Track({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.icon,
    required this.sortOrder,
    required this.colorSeed,
  });

  final String id;
  final String slug;
  final String title;
  final String description;

  /// Material icon code-point name resolved in the UI layer.
  final String icon;
  final int sortOrder;
  final String colorSeed;
}

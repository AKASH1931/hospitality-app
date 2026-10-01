class Worker {
  final String id;
  final String name;
  final String category; // Chef, Waiter, Bartender, Housekeeping, Decor, Manager
  final double rating;
  final int reviewsCount;
  final int dayRate; // Rs per day
  final String location;
  final int experienceYears;
  final List<String> skills;
  final bool isAvailable;
  final String about;

  const Worker({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.reviewsCount,
    required this.dayRate,
    required this.location,
    required this.experienceYears,
    required this.skills,
    required this.isAvailable,
    required this.about,
  });
}

class UserData {
  final String? imagePath;
  final String? name;
  final String? about;
  final String? creationDate;
  final int numPokeFavs;
  final bool isDarkMode;

  const UserData({
    required this.imagePath,
    required this.name,
    required this.about,
    required this.creationDate,
    required this.numPokeFavs,
    required this.isDarkMode,
  });
}

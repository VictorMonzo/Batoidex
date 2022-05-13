class UserData {
  final String? imagePath;
  final String? name;
  final String? about;
  final String? creationDate;
  final int? numPokeFavs;

  const UserData({
    required this.imagePath,
    required this.name,
    required this.about,
    required this.creationDate,
    required this.numPokeFavs,
  });

  static UserData fromJson(Map<String, dynamic> json) => UserData(
      imagePath: json['imagePath'],
      name: json['name'],
      about: json['about'],
      creationDate: json['data_creation'],
      numPokeFavs: json['num_poke_favorites']);
}
